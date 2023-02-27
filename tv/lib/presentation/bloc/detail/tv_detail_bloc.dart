import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail getTVDetail;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  static const String messageSuccessAdded = 'Added to Watchlist';
  static const String messageSuccessRemoved = 'Removed from Watchlist';

  TVDetailBloc(
      {required this.getTVDetail,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(TVDetailState.initial()) {
    on<FetchTVDetail>((event, emit) async {
      emit(state.insert(tvDetailState: RequestState.Loading));
      final result = await getTVDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(state.insert(
              tvDetailState: RequestState.Error, message: failure.message));
        },
        (data) {
          emit(
              state.insert(tvDetailState: RequestState.Loaded, tvDetail: data));
        },
      );
    });
    on<AddTVWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(state.insert(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.insert(watchlistMessage: successMessage));
        },
      );
      add(LoadTVWatchlistStatus(event.tv.id));
    });
    on<RemoveTVWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(state.insert(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.insert(watchlistMessage: successMessage));
        },
      );
      add(LoadTVWatchlistStatus(event.tv.id));
    });
    on<LoadTVWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.insert(isAddedToWatchlist: result));
    });
  }
}

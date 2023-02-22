import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class TVWatchlistBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchlistTV getWatchlistTV;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;
  static const String messageSuccessAdded = 'Success Added to Watchlist';
  static const String messageSuccessRemoved = 'Success Removed from Watchlist';

  TVWatchlistBloc(
      {required this.getWatchlistTV,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(WatchlistTVEmpty()) {
    on<FetchTVWatchlist>((event, emit) async {
      emit(WatchlistTVLoading());
      final watchlistTVResult = await getWatchlistTV.execute();
      watchlistTVResult.fold(
        (failure) {
          emit(WatchlistTVError(failure.message));
        },
        (data) {
          emit(WatchlistTVHasData(data));
        },
      );
    });
    on<AddTVWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(WatchlistTVError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTVMessage(successMessage));
        },
      );
    });
    on<RemoveTVWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(WatchlistTVError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTVMessage(successMessage));
        },
      );
    });
    on<LoadTVWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistTVGetStatus(result));
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(DetailEmpty()) {
    on<FetchTVDetail>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await getTVDetail.execute(event.id);
      final recommendationResult = await getTVRecommendations.execute(event.id);
      final result = await getWatchListStatus.execute(event.id);
      detailResult.fold(
        (failure) {
          emit(DetailError(failure.message));
        },
        (detail) {
          recommendationResult.fold(
            (failure) {
              emit(DetailError(failure.message));
            },
            (recommended) {
              emit(DetailHasData(detail, recommended, result));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(WatchlistMessageLoaded(failure.message));
        },
        (successMessage) {
          emit(WatchlistMessageLoaded(successMessage));
        },
      );
    });
    on<RemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);
      result.fold(
        (failure) {
          emit(WatchlistMessageLoaded(failure.message));
        },
        (successMessage) {
          emit(WatchlistMessageLoaded(successMessage));
        },
      );
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistStatusLoaded(result));
    });
  }
}

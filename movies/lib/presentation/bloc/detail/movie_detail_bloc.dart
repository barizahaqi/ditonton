import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovies getWatchListStatus;
  final SaveWatchlistMovies saveWatchlist;
  final RemoveWatchlistMovies removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(DetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);
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
      final result = await saveWatchlist.execute(event.movie);
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
      final result = await removeWatchlist.execute(event.movie);
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

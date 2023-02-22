import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_watchlist_movies.dart';
import 'package:movies/domain/usecases/save_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class MovieWatchlistBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatusMovies getWatchListStatus;
  final SaveWatchlistMovies saveWatchlist;
  final RemoveWatchlistMovies removeWatchlist;
  static const String messageSuccessAdded = 'Success Added to Watchlist';
  static const String messageSuccessRemoved = 'Success Removed from Watchlist';

  MovieWatchlistBloc(
      {required this.getWatchlistMovies,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(WatchlistMovieEmpty()) {
    on<FetchMovieWatchlist>((event, emit) async {
      emit(WatchlistMovieLoading());
      final watchlistMoviesResult = await getWatchlistMovies.execute();
      watchlistMoviesResult.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          emit(WatchlistMoviesHasData(data));
        },
      );
    });
    on<AddMovieWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (successMessage) {
          emit(WatchlistMovieMessage(messageSuccessAdded));
        },
      );
    });
    on<RemoveMovieWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (successMessage) {
          emit(WatchlistMovieMessage(messageSuccessRemoved));
        },
      );
    });
    on<LoadMovieWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchlistMovieGetStatus(result));
    });
  }
}

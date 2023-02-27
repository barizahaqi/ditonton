import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class MovieWatchlistBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc({required this.getWatchlistMovies})
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
  }
}

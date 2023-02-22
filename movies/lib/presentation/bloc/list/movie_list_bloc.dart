import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

@override
Stream<Transition<MovieListEvent, MovieListState>> transformEvents(
    Stream<MovieListEvent> events, transitionFn) {
  return events.flatMap(transitionFn);
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(ListEmpty()) {
    on<FetchMovieNowPlaying>((event, emit) async {
      emit(ListLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListNowPlayingMoviesHasData(data));
        },
      );
    });

    on<FetchMovieTopRated>((event, emit) async {
      emit(ListLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListTopRatedMoviesHasData(data));
        },
      );
    });
    on<FetchMoviePopular>((event, emit) async {
      emit(ListLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListPopularMoviesHasData(data));
        },
      );
    });
  }
}

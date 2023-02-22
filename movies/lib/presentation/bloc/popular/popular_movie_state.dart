part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieEmpty extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMovieState {
  final List<Movie> popularResult;

  PopularMoviesHasData(this.popularResult);

  @override
  List<Object> get props => [popularResult];
}

part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends TopRatedMovieState {}

class TopRatedLoading extends TopRatedMovieState {}

class TopRatedError extends TopRatedMovieState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
class TopRatedMoviesHasData extends TopRatedMovieState {
  final List<Movie> topRatedResult;

  TopRatedMoviesHasData(this.topRatedResult);

  @override
  List<Object> get props => [topRatedResult];
}

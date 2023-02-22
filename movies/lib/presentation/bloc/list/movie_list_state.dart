part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class ListEmpty extends MovieListState {}

class ListLoading extends MovieListState {}

class ListError extends MovieListState {
  final String message;

  ListError(this.message);

  @override
  List<Object> get props => [message];
}

class ListNowPlayingMoviesHasData extends MovieListState {
  final List<Movie> nowPlayingResult;

  ListNowPlayingMoviesHasData(this.nowPlayingResult);

  @override
  List<Object> get props => [nowPlayingResult];
}

class ListTopRatedMoviesHasData extends MovieListState {
  final List<Movie> topRatedResult;

  ListTopRatedMoviesHasData(this.topRatedResult);

  @override
  List<Object> get props => [topRatedResult];
}

class ListPopularMoviesHasData extends MovieListState {
  final List<Movie> popularResult;

  ListPopularMoviesHasData(this.popularResult);

  @override
  List<Object> get props => [popularResult];
}

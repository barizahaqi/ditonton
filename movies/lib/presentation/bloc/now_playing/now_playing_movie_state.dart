part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieEmpty extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMovieState {
  final List<Movie> nowPlayingResult;

  NowPlayingMoviesHasData(this.nowPlayingResult);

  @override
  List<Object> get props => [nowPlayingResult];
}

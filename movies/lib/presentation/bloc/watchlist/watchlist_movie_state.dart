part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMovieState {
  final List<Movie> watchlistResult;

  WatchlistMoviesHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String watchlistMessage;

  WatchlistMovieMessage(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class WatchlistMovieGetStatus extends WatchlistMovieState {
  final bool watchlistStatus;

  WatchlistMovieGetStatus(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

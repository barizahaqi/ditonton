part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistMovieState {}

class WatchlistLoading extends WatchlistMovieState {}

class WatchlistError extends WatchlistMovieState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMovieState {
  final List<Movie> watchlistResult;

  WatchlistMoviesHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

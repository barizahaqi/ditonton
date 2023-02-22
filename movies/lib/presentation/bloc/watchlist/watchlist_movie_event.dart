part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWatchlist extends WatchlistMovieEvent {}

class AddMovieWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadMovieWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  LoadMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

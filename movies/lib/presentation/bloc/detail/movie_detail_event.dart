part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

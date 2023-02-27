part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadMovieWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

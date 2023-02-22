part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

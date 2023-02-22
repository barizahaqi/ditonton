part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class DetailMovieEmpty extends MovieDetailState {}

class DetailMovieLoading extends MovieDetailState {}

class DetailMovieError extends MovieDetailState {
  final String message;

  DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail detailResult;

  MovieDetailHasData(this.detailResult);

  @override
  List<Object> get props => [detailResult];
}

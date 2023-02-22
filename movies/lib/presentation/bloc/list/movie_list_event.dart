part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieNowPlaying extends MovieListEvent {}

class FetchMovieTopRated extends MovieListEvent {}

class FetchMoviePopular extends MovieListEvent {}

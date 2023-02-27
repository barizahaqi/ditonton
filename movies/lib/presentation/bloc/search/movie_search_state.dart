part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends MovieSearchState {}

class SearchMovieLoading extends MovieSearchState {}

class SearchMovieError extends MovieSearchState {
  final String message;

  SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends MovieSearchState {
  final List<Movie> result;

  SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

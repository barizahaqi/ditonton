part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {}

class OnQueryChanged extends MovieSearchEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

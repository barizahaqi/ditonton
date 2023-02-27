part of 'tv_search_bloc.dart';

abstract class TVSearchEvent extends Equatable {}

class OnQueryChanged extends TVSearchEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

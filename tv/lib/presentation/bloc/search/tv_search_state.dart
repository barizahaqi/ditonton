part of 'tv_search_bloc.dart';

abstract class TVSearchState extends Equatable {
  const TVSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends TVSearchState {}

class SearchLoading extends TVSearchState {}

class SearchError extends TVSearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends TVSearchState {
  final List<TV> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

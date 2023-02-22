part of 'tv_list_bloc.dart';

abstract class TVListState extends Equatable {
  const TVListState();

  @override
  List<Object> get props => [];
}

class ListEmpty extends TVListState {}

class ListLoading extends TVListState {}

class ListError extends TVListState {
  final String message;

  ListError(this.message);

  @override
  List<Object> get props => [message];
}

class ListNowPlayingTVHasData extends TVListState {
  final List<TV> nowPlayingResult;

  ListNowPlayingTVHasData(this.nowPlayingResult);

  @override
  List<Object> get props => [nowPlayingResult];
}

class ListTopRatedTVHasData extends TVListState {
  final List<TV> topRatedResult;

  ListTopRatedTVHasData(this.topRatedResult);

  @override
  List<Object> get props => [topRatedResult];
}

class ListPopularTVHasData extends TVListState {
  final List<TV> popularResult;

  ListPopularTVHasData(this.popularResult);

  @override
  List<Object> get props => [popularResult];
}

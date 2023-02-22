part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();

  @override
  List<Object> get props => [];
}

class TopRatedTVEmpty extends TopRatedTVState {}

class TopRatedTVLoading extends TopRatedTVState {}

class TopRatedTVError extends TopRatedTVState {
  final String message;

  TopRatedTVError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVHasData extends TopRatedTVState {
  final List<TV> topRatedResult;

  TopRatedTVHasData(this.topRatedResult);

  @override
  List<Object> get props => [topRatedResult];
}

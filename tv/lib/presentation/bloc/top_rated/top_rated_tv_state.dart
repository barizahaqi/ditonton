part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends TopRatedTVState {}

class TopRatedLoading extends TopRatedTVState {}

class TopRatedError extends TopRatedTVState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVHasData extends TopRatedTVState {
  final List<TV> topRatedResult;

  TopRatedTVHasData(this.topRatedResult);

  @override
  List<Object> get props => [topRatedResult];
}

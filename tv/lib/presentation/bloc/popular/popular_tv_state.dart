part of 'popular_tv_bloc.dart';

abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object> get props => [];
}

class PopularTVEmpty extends PopularTVState {}

class PopularTVLoading extends PopularTVState {}

class PopularTVError extends PopularTVState {
  final String message;

  PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVHasData extends PopularTVState {
  final List<TV> popularResult;

  PopularTVHasData(this.popularResult);

  @override
  List<Object> get props => [popularResult];
}

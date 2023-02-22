part of 'popular_tv_bloc.dart';

abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends PopularTVState {}

class PopularLoading extends PopularTVState {}

class PopularError extends PopularTVState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVHasData extends PopularTVState {
  final List<TV> popularResult;

  PopularTVHasData(this.popularResult);

  @override
  List<Object> get props => [popularResult];
}

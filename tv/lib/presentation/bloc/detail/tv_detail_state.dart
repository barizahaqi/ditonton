part of 'tv_detail_bloc.dart';

abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object> get props => [];
}

class DetailTVEmpty extends TVDetailState {}

class DetailTVLoading extends TVDetailState {}

class DetailTVError extends TVDetailState {
  final String message;

  DetailTVError(this.message);

  @override
  List<Object> get props => [message];
}

class TVDetailHasData extends TVDetailState {
  final TVDetail detailResult;

  TVDetailHasData(this.detailResult);

  @override
  List<Object> get props => [detailResult];
}

part of 'tv_detail_bloc.dart';

abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends TVDetailState {}

class DetailLoading extends TVDetailState {}

class DetailError extends TVDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends TVDetailState {
  final TVDetail detailResult;
  final List<TV> recommendationResult;
  final bool isAdded;

  DetailHasData(this.detailResult, this.recommendationResult, this.isAdded);

  @override
  List<Object> get props => [detailResult, recommendationResult, isAdded];
}

class WatchlistMessageLoaded extends TVDetailState {
  final String watchlistMessage;

  WatchlistMessageLoaded(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class WatchlistStatusLoaded extends TVDetailState {
  final bool watchlistStatus;

  WatchlistStatusLoaded(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

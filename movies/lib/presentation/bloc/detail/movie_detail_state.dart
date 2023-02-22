part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends MovieDetailState {}

class DetailLoading extends MovieDetailState {}

class DetailError extends MovieDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends MovieDetailState {
  final MovieDetail detailResult;
  final List<Movie> recommendationResult;
  final bool isAdded;

  DetailHasData(this.detailResult, this.recommendationResult, this.isAdded);

  @override
  List<Object> get props => [detailResult, recommendationResult, isAdded];
}

class WatchlistMessageLoaded extends MovieDetailState {
  final String watchlistMessage;

  WatchlistMessageLoaded(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class WatchlistStatusLoaded extends MovieDetailState {
  final bool watchlistStatus;

  WatchlistStatusLoaded(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

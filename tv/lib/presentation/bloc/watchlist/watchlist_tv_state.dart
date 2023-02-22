part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object> get props => [];
}

class WatchlistTVEmpty extends WatchlistTVState {}

class WatchlistTVLoading extends WatchlistTVState {}

class WatchlistTVError extends WatchlistTVState {
  final String message;

  WatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVHasData extends WatchlistTVState {
  final List<TV> watchlistResult;

  WatchlistTVHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

class WatchlistTVMessage extends WatchlistTVState {
  final String watchlistMessage;

  WatchlistTVMessage(this.watchlistMessage);

  @override
  List<Object> get props => [watchlistMessage];
}

class WatchlistTVGetStatus extends WatchlistTVState {
  final bool watchlistStatus;

  WatchlistTVGetStatus(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}

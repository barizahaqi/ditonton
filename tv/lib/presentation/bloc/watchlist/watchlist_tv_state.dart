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

part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistTVState {}

class WatchlistLoading extends WatchlistTVState {}

class WatchlistError extends WatchlistTVState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVHasData extends WatchlistTVState {
  final List<TV> watchlistResult;

  WatchlistTVHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

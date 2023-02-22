part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVEvent extends Equatable {
  const WatchlistTVEvent();

  @override
  List<Object> get props => [];
}

class FetchTVWatchlist extends WatchlistTVEvent {}

class AddTVWatchlist extends WatchlistTVEvent {
  final TVDetail tv;

  AddTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTVWatchlist extends WatchlistTVEvent {
  final TVDetail tv;

  RemoveTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadTVWatchlistStatus extends WatchlistTVEvent {
  final int id;

  LoadTVWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

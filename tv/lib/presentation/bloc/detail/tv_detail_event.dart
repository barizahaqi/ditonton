part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {}

class FetchTVDetail extends TVDetailEvent {
  final int id;

  FetchTVDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTVWatchlist extends TVDetailEvent {
  final TVDetail tv;

  AddTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTVWatchlist extends TVDetailEvent {
  final TVDetail tv;

  RemoveTVWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadTVWatchlistStatus extends TVDetailEvent {
  final int id;

  LoadTVWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

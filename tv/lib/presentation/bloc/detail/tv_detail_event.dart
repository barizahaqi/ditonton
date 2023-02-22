part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTVDetail extends TVDetailEvent {
  final int id;

  FetchTVDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TVDetailEvent {
  final TVDetail tv;

  AddWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveWatchlist extends TVDetailEvent {
  final TVDetail tv;

  RemoveWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistStatus extends TVDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {}

class FetchTVDetail extends TVDetailEvent {
  final int id;

  FetchTVDetail(this.id);

  @override
  List<Object> get props => [id];
}

part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVEvent extends Equatable {
  const TopRatedTVEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedTV extends TopRatedTVEvent {}

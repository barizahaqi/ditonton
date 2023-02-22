part of 'tv_list_bloc.dart';

abstract class TVListEvent extends Equatable {
  const TVListEvent();

  @override
  List<Object> get props => [];
}

class FetchTVNowPlaying extends TVListEvent {}

class FetchTVTopRated extends TVListEvent {}

class FetchTVPopular extends TVListEvent {}

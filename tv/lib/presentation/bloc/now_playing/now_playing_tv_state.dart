part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {
  const NowPlayingTVState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmpty extends NowPlayingTVState {}

class NowPlayingLoading extends NowPlayingTVState {}

class NowPlayingError extends NowPlayingTVState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVHasData extends NowPlayingTVState {
  final List<TV> nowPlayingResult;

  NowPlayingTVHasData(this.nowPlayingResult);

  @override
  List<Object> get props => [nowPlayingResult];
}

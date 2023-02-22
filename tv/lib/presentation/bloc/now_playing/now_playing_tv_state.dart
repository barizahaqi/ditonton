part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {
  const NowPlayingTVState();

  @override
  List<Object> get props => [];
}

class NowPlayingTVEmpty extends NowPlayingTVState {}

class NowPlayingTVLoading extends NowPlayingTVState {}

class NowPlayingTVError extends NowPlayingTVState {
  final String message;

  NowPlayingTVError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVHasData extends NowPlayingTVState {
  final List<TV> nowPlayingResult;

  NowPlayingTVHasData(this.nowPlayingResult);

  @override
  List<Object> get props => [nowPlayingResult];
}

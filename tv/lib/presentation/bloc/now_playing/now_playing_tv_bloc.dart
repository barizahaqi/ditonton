import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTVBloc extends Bloc<NowPlayingTVEvent, NowPlayingTVState> {
  final GetNowPlayingTV getNowPlayingTV;

  NowPlayingTVBloc(this.getNowPlayingTV) : super(NowPlayingEmpty()) {
    on<FetchNowPlayingTV>((event, emit) async {
      emit(NowPlayingLoading());
      final nowPlayingResult = await getNowPlayingTV.execute();
      nowPlayingResult.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (data) {
          emit(NowPlayingTVHasData(data));
        },
      );
    });
  }
}

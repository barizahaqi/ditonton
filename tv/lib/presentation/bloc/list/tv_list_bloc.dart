import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/tv.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

@override
Stream<Transition<TVListEvent, TVListState>> transformEvents(
    Stream<TVListEvent> events, transitionFn) {
  return events.flatMap(transitionFn);
}

class TVListBloc extends Bloc<TVListEvent, TVListState> {
  final GetNowPlayingTV getNowPlayingTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  TVListBloc({
    required this.getNowPlayingTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  }) : super(ListEmpty()) {
    on<FetchTVNowPlaying>((event, emit) async {
      emit(ListLoading());
      final result = await getNowPlayingTV.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListNowPlayingTVHasData(data));
        },
      );
    });

    on<FetchTVTopRated>((event, emit) async {
      emit(ListLoading());
      final result = await getTopRatedTV.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListTopRatedTVHasData(data));
        },
      );
    });
    on<FetchTVPopular>((event, emit) async {
      emit(ListLoading());
      final result = await getPopularTV.execute();
      result.fold(
        (failure) {
          emit(ListError(failure.message));
        },
        (data) {
          emit(ListPopularTVHasData(data));
        },
      );
    });
  }
}

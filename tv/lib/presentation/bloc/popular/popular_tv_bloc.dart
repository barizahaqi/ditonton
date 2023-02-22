import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV getPopularTV;

  PopularTVBloc(this.getPopularTV) : super(PopularTVEmpty()) {
    on<FetchPopularTV>((event, emit) async {
      emit(PopularTVLoading());
      final popularResult = await getPopularTV.execute();
      popularResult.fold(
        (failure) {
          emit(PopularTVError(failure.message));
        },
        (data) {
          emit(PopularTVHasData(data));
        },
      );
    });
  }
}

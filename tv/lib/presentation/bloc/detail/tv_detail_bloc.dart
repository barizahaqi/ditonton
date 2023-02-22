import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail getTVDetail;

  TVDetailBloc({required this.getTVDetail}) : super(DetailTVEmpty()) {
    on<FetchTVDetail>((event, emit) async {
      emit(DetailTVLoading());
      final result = await getTVDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(DetailTVError(failure.message));
        },
        (data) {
          emit(TVDetailHasData(data));
        },
      );
    });
  }
}

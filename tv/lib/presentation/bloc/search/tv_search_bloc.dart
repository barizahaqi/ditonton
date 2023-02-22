import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:core/utils/event_transformer.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTV searchTV;

  TVSearchBloc(this.searchTV) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchTV.execute(query);

      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

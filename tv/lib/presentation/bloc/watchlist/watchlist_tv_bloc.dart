import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class TVWatchlistBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  final GetWatchlistTV getWatchlistTV;

  TVWatchlistBloc({required this.getWatchlistTV}) : super(WatchlistTVEmpty()) {
    on<FetchTVWatchlist>((event, emit) async {
      emit(WatchlistTVLoading());
      final watchlistTVResult = await getWatchlistTV.execute();
      watchlistTVResult.fold(
        (failure) {
          emit(WatchlistTVError(failure.message));
        },
        (data) {
          emit(WatchlistTVHasData(data));
        },
      );
    });
  }
}

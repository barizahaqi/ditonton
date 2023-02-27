import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatusMovies getWatchListStatus;
  final SaveWatchlistMovies saveWatchlist;
  final RemoveWatchlistMovies removeWatchlist;

  static const String messageSuccessAdded = 'Success Added to Watchlist';
  static const String messageSuccessRemoved = 'Success Removed from Watchlist';

  MovieDetailBloc(
      {required this.getMovieDetail,
      required this.getWatchListStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.insert(movieDetailState: RequestState.Loading));
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(state.insert(
              movieDetailState: RequestState.Error, message: failure.message));
        },
        (data) {
          emit(state.insert(
              movieDetailState: RequestState.Loaded, movieDetail: data));
        },
      );
    });
    on<AddMovieWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
        (failure) {
          emit(state.insert(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.insert(watchlistMessage: successMessage));
        },
      );
      add(LoadMovieWatchlistStatus(event.movie.id));
    });
    on<RemoveMovieWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
        (failure) {
          emit(state.insert(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.insert(watchlistMessage: successMessage));
        },
      );
      add(LoadMovieWatchlistStatus(event.movie.id));
    });
    on<LoadMovieWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.insert(isAddedToWatchlist: result));
    });
  }
}

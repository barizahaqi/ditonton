import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final nowPlayingResult = await getNowPlayingMovies.execute();
      nowPlayingResult.fold(
        (failure) {
          emit(NowPlayingMovieError(failure.message));
        },
        (data) {
          emit(NowPlayingMoviesHasData(data));
        },
      );
    });
  }
}

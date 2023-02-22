import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());
      final topRatedResult = await getTopRatedMovies.execute();
      topRatedResult.fold(
        (failure) {
          emit(TopRatedMovieError(failure.message));
        },
        (data) {
          emit(TopRatedMoviesHasData(data));
        },
      );
    });
  }
}

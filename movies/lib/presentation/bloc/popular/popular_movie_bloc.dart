import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(PopularEmpty()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(PopularLoading());
      final popularResult = await getPopularMovies.execute();
      popularResult.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(PopularMoviesHasData(data));
        },
      );
    });
  }
}

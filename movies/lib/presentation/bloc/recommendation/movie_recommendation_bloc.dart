import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(RecommendationMovieEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      emit(RecommendationMovieLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendationMovieError(failure.message));
        },
        (data) {
          emit(RecommendationMovieHasData(data));
        },
      );
    });
  }
}

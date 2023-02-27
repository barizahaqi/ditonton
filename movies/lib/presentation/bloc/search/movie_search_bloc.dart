import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:core/utils/event_transformer.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(SearchMovieEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMovieLoading());
      final result = await searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchMovieError(failure.message));
      }, (data) {
        emit(SearchMovieHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

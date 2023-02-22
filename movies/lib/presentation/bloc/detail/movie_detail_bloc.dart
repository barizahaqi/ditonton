import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail}) : super(DetailMovieEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(DetailMovieLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(DetailMovieError(failure.message));
        },
        (data) {
          emit(MovieDetailHasData(data));
        },
      );
    });
  }
}

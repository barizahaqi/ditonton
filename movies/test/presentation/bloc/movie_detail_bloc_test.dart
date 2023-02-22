import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
    );
  });
  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];
  test('initial state should be empty', () {
    expect(bloc.state, DetailMovieEmpty());
  });
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(tId)),
    expect: () => [
      DetailMovieLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}

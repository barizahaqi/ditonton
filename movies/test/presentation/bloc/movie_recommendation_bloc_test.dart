import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:core/utils/failure.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/recommendation/movie_recommendation_bloc.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late MovieRecommendationBloc bloc;
  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    bloc = MovieRecommendationBloc(mockGetMovieRecommendation);
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

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(bloc.state, RecommendationMovieEmpty());
  });
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );
}

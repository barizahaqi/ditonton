import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:core/utils/failure.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/recommendation/tv_recommendation_bloc.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVRecommendations,
])
void main() {
  late MockGetTVRecommendations mockGetTVRecommendation;
  late TVRecommendationBloc bloc;
  late FetchTVRecommendation fetchTVRecommendation;
  setUp(() {
    mockGetTVRecommendation = MockGetTVRecommendations();
    bloc = TVRecommendationBloc(mockGetTVRecommendation);
    fetchTVRecommendation = FetchTVRecommendation(1);
  });
  final tId = 1;

  final tTV = TV(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVList = <TV>[tTV];

  test('initial state should be empty', () {
    expect(bloc.state, RecommendationTVEmpty());
  });
  blocTest<TVRecommendationBloc, TVRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVRecommendation(tId)),
    expect: () => [
      RecommendationTVLoading(),
      RecommendationTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendation.execute(tId));
    },
  );
  blocTest<TVRecommendationBloc, TVRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTVRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVRecommendation(tId)),
    expect: () => [
      RecommendationTVLoading(),
      RecommendationTVError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendation.execute(tId));
    },
  );
  test('should get property id from FetchTopRatedTV', () {
    expect(fetchTVRecommendation.props, [1]);
  });
}

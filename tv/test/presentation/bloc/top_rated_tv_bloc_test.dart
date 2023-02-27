import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedTVBloc bloc;
  late FetchTopRatedTV fetchTopRatedTV;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
    bloc = TopRatedTVBloc(getTopRatedTV: mockGetTopRatedTV);
    fetchTopRatedTV = FetchTopRatedTV();
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
    expect(bloc.state, TopRatedTVEmpty());
  });
  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTV()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );
  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTV()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );
  test('should get property empty from FetchTopRatedTV', () {
    expect(fetchTopRatedTV.props, []);
  });
}

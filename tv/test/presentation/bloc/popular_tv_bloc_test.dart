import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late MockGetPopularTV mockGetPopularTV;
  late PopularTVBloc bloc;
  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    bloc = PopularTVBloc(mockGetPopularTV);
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
    expect(bloc.state, PopularTVEmpty());
  });
  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularTV()),
    expect: () => [
      PopularTVLoading(),
      PopularTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );
  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularTV()),
    expect: () => [
      PopularTVLoading(),
      PopularTVError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );
}

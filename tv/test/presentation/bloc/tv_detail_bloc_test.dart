import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
])
void main() {
  late TVDetailBloc bloc;
  late MockGetTVDetail mockGetTVDetail;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    bloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
    );
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
    expect(bloc.state, DetailTVEmpty());
  });
  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVDetail(tId)),
    expect: () => [
      DetailTVLoading(),
      TVDetailHasData(testTVDetail),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );
  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTVDetail(tId)),
    expect: () => [
      DetailTVLoading(),
      DetailTVError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );
}

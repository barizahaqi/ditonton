import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/tv.dart';
import 'package:tv/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTV])
void main() {
  late MockGetNowPlayingTV mockGetNowPlayingTV;
  late NowPlayingTVBloc bloc;
  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTV();
    bloc = NowPlayingTVBloc(mockGetNowPlayingTV);
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
    expect(bloc.state, NowPlayingTVEmpty());
  });
  blocTest<NowPlayingTVBloc, NowPlayingTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTV()),
    expect: () => [
      NowPlayingTVLoading(),
      NowPlayingTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );
  blocTest<NowPlayingTVBloc, NowPlayingTVState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTV()),
    expect: () => [
      NowPlayingTVLoading(),
      NowPlayingTVError('Failed'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );
}

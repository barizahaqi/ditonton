import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects_tv.dart';

@GenerateMocks([
  GetWatchlistTV,
])
void main() {
  late MockGetWatchlistTV mockGetWatchlistTV;
  late TVWatchlistBloc bloc;
  late FetchTVWatchlist fetchTVWatchlist;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    fetchTVWatchlist = FetchTVWatchlist();
    bloc = TVWatchlistBloc(
      getWatchlistTV: mockGetWatchlistTV,
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
    expect(bloc.state, WatchlistTVEmpty());
  });

  group('GetWatchlistTV', () {
    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTV.execute())
            .thenAnswer((_) async => Right(tTVList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVWatchlist()),
      expect: () => [
        WatchlistTVLoading(),
        WatchlistTVHasData(tTVList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTV.execute());
      },
    );

    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVWatchlist()),
      expect: () => [
        WatchlistTVLoading(),
        WatchlistTVError("Failed"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTV.execute());
      },
    );
  });
  test('should get property empty from FetchTVWatchlist', () {
    expect(fetchTVWatchlist.props, []);
  });
}

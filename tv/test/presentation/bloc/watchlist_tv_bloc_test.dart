import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects_tv.dart';

@GenerateMocks([
  GetWatchlistTV,
  GetWatchListStatusTV,
  SaveWatchlistTV,
  RemoveWatchlistTV,
])
void main() {
  late MockGetWatchlistTV mockGetWatchlistTV;
  late TVWatchlistBloc bloc;
  late MockGetWatchListStatusTV mockGetWatchlistStatus;
  late MockSaveWatchlistTV mockSaveWatchlist;
  late MockRemoveWatchlistTV mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    mockGetWatchlistStatus = MockGetWatchListStatusTV();
    mockSaveWatchlist = MockSaveWatchlistTV();
    mockRemoveWatchlist = MockRemoveWatchlistTV();
    bloc = TVWatchlistBloc(
      getWatchlistTV: mockGetWatchlistTV,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
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

  group('GetWatchlistStatus', () {
    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'return true when TV is in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTVWatchlistStatus(tId)),
      expect: () => [WatchlistTVGetStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'return false when TV is not in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTVWatchlistStatus(tId)),
      expect: () => [WatchlistTVGetStatus(false)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });

  group('Post add and remove watchlist status', () {
    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'should update watchlist status when TV is success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail)).thenAnswer(
            (_) async => Right(TVWatchlistBloc.messageSuccessAdded));
        return bloc;
      },
      act: (bloc) => bloc.add(AddTVWatchlist(testTVDetail)),
      expect: () => [WatchlistTVMessage(TVWatchlistBloc.messageSuccessAdded)],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTVDetail));
      },
    );

    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'should throw error when TV is failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
        return bloc;
      },
      act: (bloc) => bloc.add(AddTVWatchlist(testTVDetail)),
      expect: () => [WatchlistTVError("Failed")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTVDetail));
      },
    );

    blocTest<TVWatchlistBloc, WatchlistTVState>(
      'should update watchlist status when TV is success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testTVDetail)).thenAnswer(
            (_) async => Right(TVWatchlistBloc.messageSuccessRemoved));
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveTVWatchlist(testTVDetail)),
      expect: () => [WatchlistTVMessage(TVWatchlistBloc.messageSuccessRemoved)],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTVDetail));
      },
    );
  });

  blocTest<TVWatchlistBloc, WatchlistTVState>(
    'should throw error when TV is failed removed from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveTVWatchlist(testTVDetail)),
    expect: () => [WatchlistTVError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTVDetail));
    },
  );
}

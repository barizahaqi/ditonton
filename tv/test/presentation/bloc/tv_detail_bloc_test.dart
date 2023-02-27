import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetWatchListStatusTV,
  SaveWatchlistTV,
  RemoveWatchlistTV,
])
void main() {
  late TVDetailBloc bloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetWatchListStatusTV mockGetWatchlistStatus;
  late MockSaveWatchlistTV mockSaveWatchlist;
  late MockRemoveWatchlistTV mockRemoveWatchlist;
  late FetchTVDetail fetchTVDetail;
  late AddTVWatchlist addTVWatchlist;
  late RemoveTVWatchlist removeTVWatchlist;
  late LoadTVWatchlistStatus loadTVWatchlistStatus;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusTV();
    mockSaveWatchlist = MockSaveWatchlistTV();
    mockRemoveWatchlist = MockRemoveWatchlistTV();
    bloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
    fetchTVDetail = FetchTVDetail(1);
    addTVWatchlist = AddTVWatchlist(testTVDetail);
    removeTVWatchlist = RemoveTVWatchlist(testTVDetail);
    loadTVWatchlistStatus = LoadTVWatchlistStatus(1);
  });
  final tId = 1;

  group('Get Detail TV', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [DetailTVLoading, DetailTVLoaded] when get detail TV success',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVDetail(tId)),
      expect: () => [
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loading,
        ),
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTVDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetTVDetail.execute(tId));
        FetchTVDetail(tId).props;
      },
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [DetailTVError] when get detail TV failed',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVDetail(tId)),
      expect: () => [
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loading,
        ),
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTVDetail.execute(tId));
        FetchTVDetail(tId).props;
      },
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [DetailTVLoading, DetailTVLoaded] when get recommendation TV empty',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVDetail(tId)),
      expect: () => [
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loading,
        ),
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTVDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetTVDetail.execute(tId));
        FetchTVDetail(tId).props;
      },
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [DetailTVLoading, DetailTVLoaded] when get recommendation TV failed',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTVDetail(tId)),
      expect: () => [
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loading,
        ),
        TVDetailState.initial().insert(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTVDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetTVDetail.execute(tId));
        FetchTVDetail(tId).props;
      },
    );
  });

  group('Load Watchlist Status TV', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'Should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTVWatchlistStatus(tId)),
      expect: () => [
        TVDetailState.initial().insert(isAddedToWatchlist: true),
      ],
      verify: (_) => [
        verify(mockGetWatchlistStatus.execute(tId)),
        LoadTVWatchlistStatus(tId).props,
      ],
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTVWatchlistStatus(tId)),
      expect: () => [
        TVDetailState.initial().insert(isAddedToWatchlist: false),
      ],
      verify: (_) => [
        verify(mockGetWatchlistStatus.execute(tId)),
        LoadTVWatchlistStatus(tId).props,
      ],
    );
  });

  group('Added To Watchlist TV', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(AddTVWatchlist(testTVDetail)),
      expect: () => [
        TVDetailState.initial().insert(
          watchlistMessage: 'Added to Watchlist',
        ),
        TVDetailState.initial().insert(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(testTVDetail.id));
        AddTVWatchlist(testTVDetail).props;
      },
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [WatchlistMessage] when failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(AddTVWatchlist(testTVDetail)),
      expect: () => [
        TVDetailState.initial().insert(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(testTVDetail.id));
        AddTVWatchlist(testTVDetail).props;
      },
    );
  });

  group('Remove From Watchlist TV', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveTVWatchlist(testTVDetail)),
      expect: () => [
        TVDetailState.initial().insert(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(testTVDetail.id));
        RemoveTVWatchlist(testTVDetail).props;
      },
    );

    blocTest<TVDetailBloc, TVDetailState>(
      'Shoud emit [WatchlistMessage] when failed removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveTVWatchlist(testTVDetail)),
      expect: () => [
        TVDetailState.initial().insert(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(testTVDetail.id));
        RemoveTVWatchlist(testTVDetail).props;
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_watchlist_movies.dart';
import 'package:movies/domain/usecases/save_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatusMovies,
  SaveWatchlistMovies,
  RemoveWatchlistMovies,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatusMovies mockGetWatchlistStatus;
  late MockSaveWatchlistMovies mockSaveWatchlist;
  late MockRemoveWatchlistMovies mockRemoveWatchlist;
  late FetchMovieDetail fetchMovieDetail;
  late AddMovieWatchlist addMovieWatchlist;
  late RemoveMovieWatchlist removeMovieWatchlist;
  late LoadMovieWatchlistStatus loadMovieWatchlistStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusMovies();
    mockSaveWatchlist = MockSaveWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlistMovies();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
    fetchMovieDetail = FetchMovieDetail(1);
    addMovieWatchlist = AddMovieWatchlist(testMovieDetail);
    removeMovieWatchlist = RemoveMovieWatchlist(testMovieDetail);
    loadMovieWatchlistStatus = LoadMovieWatchlistStatus(1);
  });
  final tId = 1;

  group('Get Detail Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded] when get detail movie success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        FetchMovieDetail(tId).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieError] when get detail movie failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        FetchMovieDetail(tId).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded] when get recommendation movies empty',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        FetchMovieDetail(tId).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded] when get recommendation movies failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().insert(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        FetchMovieDetail(tId).props;
      },
    );
  });

  group('Load Watchlist Status Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMovieWatchlistStatus(tId)),
      expect: () => [
        MovieDetailState.initial().insert(isAddedToWatchlist: true),
      ],
      verify: (_) => [
        verify(mockGetWatchlistStatus.execute(tId)),
        LoadMovieWatchlistStatus(tId).props,
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMovieWatchlistStatus(tId)),
      expect: () => [
        MovieDetailState.initial().insert(isAddedToWatchlist: false),
      ],
      verify: (_) => [
        verify(mockGetWatchlistStatus.execute(tId)),
        LoadMovieWatchlistStatus(tId).props,
      ],
    );
  });

  group('Added To Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().insert(
          watchlistMessage: 'Added to Watchlist',
        ),
        MovieDetailState.initial().insert(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        AddMovieWatchlist(testMovieDetail).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage] when failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().insert(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        AddMovieWatchlist(testMovieDetail).props;
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().insert(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        RemoveMovieWatchlist(testMovieDetail).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage] when failed removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().insert(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        RemoveMovieWatchlist(testMovieDetail).props;
      },
    );
  });
}

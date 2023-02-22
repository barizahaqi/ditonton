import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movies.dart';
import 'package:movies/domain/usecases/remove_watchlist_movies.dart';
import 'package:movies/domain/usecases/save_watchlist_movies.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects_movies.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatusMovies,
  SaveWatchlistMovies,
  RemoveWatchlistMovies,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistBloc bloc;
  late MockGetWatchListStatusMovies mockGetWatchlistStatus;
  late MockSaveWatchlistMovies mockSaveWatchlist;
  late MockRemoveWatchlistMovies mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistStatus = MockGetWatchListStatusMovies();
    mockSaveWatchlist = MockSaveWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlistMovies();
    bloc = MovieWatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
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
  final tMovies = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistMovieEmpty());
  });

  group('GetWatchlistMovies', () {
    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieWatchlist()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMoviesHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMovieWatchlist()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError("Failed"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group('GetWatchlistStatus', () {
    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'return true when movie is in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMovieWatchlistStatus(tId)),
      expect: () => [WatchlistMovieGetStatus(true)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'return false when movie is not in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMovieWatchlistStatus(tId)),
      expect: () => [WatchlistMovieGetStatus(false)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });

  group('Post add and remove watchlist status', () {
    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'should update watchlist status when movie is success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Right(MovieWatchlistBloc.messageSuccessAdded));
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () =>
          [WatchlistMovieMessage(MovieWatchlistBloc.messageSuccessAdded)],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'should throw error when movie is failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () => [WatchlistMovieError("Failed")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistMovieState>(
      'should update watchlist status when movie is success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => Right(MovieWatchlistBloc.messageSuccessRemoved));
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveMovieWatchlist(testMovieDetail)),
      expect: () =>
          [WatchlistMovieMessage(MovieWatchlistBloc.messageSuccessRemoved)],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });

  blocTest<MovieWatchlistBloc, WatchlistMovieState>(
    'should throw error when movie is failed removed from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure("Failed")));
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveMovieWatchlist(testMovieDetail)),
    expect: () => [WatchlistMovieError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}

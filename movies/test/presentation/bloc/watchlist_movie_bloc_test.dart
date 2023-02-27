import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

import 'package:movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movie_bloc_test.mocks.dart';
import '../../dummy_data/dummy_objects_movies.dart';

@GenerateMocks([
  GetWatchlistMovies,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistBloc bloc;

  late FetchMovieWatchlist fetchMovieWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();

    bloc = MovieWatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
    fetchMovieWatchlist = FetchMovieWatchlist();
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
  test('should get property empty from FetchMovieWatchlist', () {
    expect(fetchMovieWatchlist.props, []);
  });
}

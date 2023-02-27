import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTVModel = TVModel(
    backdropPath: '/jMxwjnzjnTZz3ku6nJWvjg0T2nd.jpg',
    firstAirDate: '2016-03-30',
    genreIds: [18],
    id: 65227,
    name: 'The Path',
    originalName: 'The Path',
    overview:
        'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
    popularity: 11.737,
    posterPath: '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
    voteAverage: 6.6,
    voteCount: 115,
  );

  final tTV = TV(
    backdropPath: '/jMxwjnzjnTZz3ku6nJWvjg0T2nd.jpg',
    firstAirDate: '2016-03-30',
    genreIds: [18],
    id: 65227,
    name: 'The Path',
    originalName: 'The Path',
    overview:
        'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
    popularity: 11.737,
    posterPath: '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
    voteAverage: 6.6,
    voteCount: 115,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('Now Playing TV', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingTV()).thenAnswer((_) async => []);
      // act
      await repository.getNowPlayingTV();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenAnswer((_) async => tTVModelList);
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenAnswer((_) async => tTVModelList);
        // act
        await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        verify(mockLocalDataSource.cacheNowPlayingTV([testTVCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingTV())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockRemoteDataSource.getNowPlayingTV());
        expect(result, equals(Left(ServerFailure(''))));
      });
      test(
        'should return SSL failure when certificate verify failed',
        () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTV())
              .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getNowPlayingTV();
          // assert
          expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTV())
            .thenAnswer((_) async => [testTVCache]);
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTV());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTVFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingTV())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getNowPlayingTV();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingTV());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular TV', () {
    test('should return TV list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
    test(
      'should return SSL failure when certificate verify failed',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTV())
            .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
        // act
        final result = await repository.getPopularTV();
        // assert
        expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      },
    );
  });

  group('Top Rated TV', () {
    test('should return TV list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
    test(
      'should return SSL failure when certificate verify failed',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTV())
            .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
        // act
        final result = await repository.getTopRatedTV();
        // assert
        expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      },
    );
  });

  group('Get TV Detail', () {
    final tId = 1;
    final tTVResponse = TVDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      episodeRunTime: [120],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'https://google.com',
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 10,
      numberOfSeasons: 2,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => tTVResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTVDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
    test(
      'should return SSL failure when certificate verify failed',
      () async {
        // arrange
        when(mockRemoteDataSource.getTVDetail(tId))
            .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
        // act
        final result = await repository.getTVDetail(tId);
        // assert
        expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      },
    );
  });

  group('Get TV Recommendations', () {
    final tTVList = <TVModel>[];
    final tId = 1;

    test('should return data (TV list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
    test(
      'should return SSL failure when certificate verify failed',
      () async {
        // arrange
        when(mockRemoteDataSource.getTVRecommendations(tId))
            .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
        // act
        final result = await repository.getTVRecommendations(tId);
        // assert
        expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      },
    );
  });

  group('Seach TV', () {
    final tQuery = 'spiderman';

    test('should return TV list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
    test(
      'should return SSL failure when certificate verify failed',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTV(tQuery))
            .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
        // act
        final result = await repository.searchTV(tQuery);
        // assert
        expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      },
    );
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TV', () {
    test('should return list of TV', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}

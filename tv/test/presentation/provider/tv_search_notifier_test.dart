import 'package:dartz/dartz.dart';
import 'package:core/utils//failure.dart';
import 'package:core/utils//state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTV mockSearchTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTV = MockSearchTV();
    provider = TVSearchNotifier(searchTV: mockSearchTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVModel = TV(
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
  final tTVList = <TV>[tTVModel];
  final tQuery = 'the path';

  group('search TV', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

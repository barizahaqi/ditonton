import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchBloc searchBloc;
  late MockSearchTV mockSearchTVs;

  setUp(() {
    mockSearchTVs = MockSearchTV();
    searchBloc = TVSearchBloc(mockSearchTVs);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
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

  blocTest<TVSearchBloc, TVSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tQuery));
    },
  );

  blocTest<TVSearchBloc, TVSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tQuery));
    },
  );
}

import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/pages/watchlist_movie_page.dart';
import 'package:provider/provider.dart';

import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([MovieWatchlistBloc])
void main() {
  late MockMovieWatchlistBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(WatchlistMovieLoading());
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(WatchlistMoviesHasData([]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMoviesHasData([])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(WatchlistMovieError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieError('Error message')));

    final textFinder = find.text('Error message');
    ;

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

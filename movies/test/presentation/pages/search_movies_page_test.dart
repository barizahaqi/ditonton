import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_movies_page_test.mocks.dart';

@GenerateMocks([MovieSearchBloc])
void main() {
  late MockMovieSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(SearchMovieLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(SearchMovieLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchMoviesPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(SearchMovieHasData([]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(SearchMovieHasData([])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(SearchMovieError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(SearchMovieError('Error message')));

    final textFinder = find.text('Error message');
    ;

    await tester.pumpWidget(_makeTestableWidget(SearchMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

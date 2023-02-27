import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects_movies.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMovieBloc])
void main() {
  late MockPopularMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PopularMovieLoading());
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PopularMoviesHasData(<Movie>[]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(<Movie>[])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PopularMovieError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieError('Error message')));

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects_movies.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeDetailMovieEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

void main() {
  late MockMovieDetailBloc mockBloc;
  late DetailContent detailContent;

  setUpAll(() {
    registerFallbackValue(FakeDetailMovieEvent());
    registerFallbackValue(FakeMovieDetailState());
  });

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    detailContent = DetailContent(testMovieDetail, true, 1);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
        value: mockBloc,
        child: MaterialApp(
          home: body,
        ));
  }

  int tId = 1;

  testWidgets('Show display alert dialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([
        MovieDetailState.initial().insert(
          isAddedToWatchlist: false,
        ),
        MovieDetailState.initial().insert(
          isAddedToWatchlist: false,
          watchlistMessage: 'Failed Add to Watchlist',
        ),
      ]),
      initialState: MovieDetailState.initial(),
    );

    final alertDialog = find.byType(AlertDialog);
    final textMessage = find.text('Failed Add to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(alertDialog, findsNothing);
    expect(textMessage, findsNothing);

    await tester.pump();

    expect(alertDialog, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Movie detail page should display error text when no internet network',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      MovieDetailState.initial().insert(
        movieDetailState: RequestState.Error,
        message: 'Failed to connect to the network',
      ),
    );

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}

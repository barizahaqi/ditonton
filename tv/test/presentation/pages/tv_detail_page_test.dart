import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects_tv.dart';

class MockTVDetailBloc extends MockBloc<TVDetailEvent, TVDetailState>
    implements TVDetailBloc {}

class FakeDetailTVEvent extends Fake implements TVDetailEvent {}

class FakeTVDetailState extends Fake implements TVDetailState {}

void main() {
  late MockTVDetailBloc mockBloc;
  late DetailContent detailContent;

  setUpAll(() {
    registerFallbackValue(FakeDetailTVEvent());
    registerFallbackValue(FakeTVDetailState());
  });

  setUp(() {
    mockBloc = MockTVDetailBloc();
    detailContent = DetailContent(testTVDetail, true, 1);
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailBloc>.value(
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
        TVDetailState.initial().insert(
          isAddedToWatchlist: false,
        ),
        TVDetailState.initial().insert(
          isAddedToWatchlist: false,
          watchlistMessage: 'Failed Add to Watchlist',
        ),
      ]),
      initialState: TVDetailState.initial(),
    );

    final alertDialog = find.byType(AlertDialog);
    final textMessage = find.text('Failed Add to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: tId)));

    expect(alertDialog, findsNothing);
    expect(textMessage, findsNothing);

    await tester.pump();

    expect(alertDialog, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'TV detail page should display error text when no internet network',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TVDetailState.initial().insert(
        tvDetailState: RequestState.Error,
        message: 'Failed to connect to the network',
      ),
    );

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}

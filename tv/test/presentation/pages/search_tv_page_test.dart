import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';

import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TVSearchBloc])
void main() {
  late MockTVSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockTVSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVSearchLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TVSearchLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVSearchHasData([]));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TVSearchHasData([])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVSearchError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TVSearchError('Error message')));

    final textFinder = find.text('Error message');
    ;

    await tester.pumpWidget(_makeTestableWidget(SearchTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

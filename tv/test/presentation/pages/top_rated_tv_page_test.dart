import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTVBloc])
void main() {
  late MockTopRatedTVBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedTVLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedTVLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedTVHasData([]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTVHasData([])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedTVError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTVError('Error message')));

    final textFinder = find.text('Error message');
    ;

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:tv/presentation/provider/now_playing_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'now_playing_tv_page_test.mocks.dart';

@GenerateMocks([NowPlayingTVNotifier])
void main() {
  late MockNowPlayingTVNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockNowPlayingTVNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NowPlayingTVNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(<TV>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

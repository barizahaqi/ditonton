import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'now_playing_tv_page_test.mocks.dart';

@GenerateMocks([NowPlayingTVBloc])
void main() {
  late MockNowPlayingTVBloc mockBloc;

  setUp(() {
    mockBloc = MockNowPlayingTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(NowPlayingTVLoading());
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(NowPlayingTVLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(NowPlayingTVHasData(<TV>[]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(NowPlayingTVHasData(<TV>[])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(NowPlayingTVError('Error message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(NowPlayingTVError('Error message')));

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTVPage()));

    expect(textFinder, findsOneWidget);
  });
}

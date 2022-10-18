import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_pokedex/main.dart';

abstract class Robot {
  static const deviseSizeDefault = Size(1440, 2560);
  final WidgetTester tester;
  late NavigatorObserver navigatorObserver;

  Robot(this.tester);

  Future<void> setupApp({
    Widget? widget,
    Size? sizeScreen,
  }) async {
    tester.binding.window.physicalSizeTestValue =
        sizeScreen ?? deviseSizeDefault;
    await tester.pumpWidget(widget ?? const MyApp());
    await tester.pumpAndSettle();
  }

  Future takeSnapshot(String filename) {
    return expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('./golden_files/$filename.png'),
    );
  }

  Future didScrollToUp({double startY = 300, double endY = -500}) async {
    final gesture = await tester.startGesture(
      Offset(0, startY),
    ); //Position of the scrollview
    await gesture.moveBy(Offset(0, endY)); //How much to scroll by
    await tester.pump();
  }

  Future didScrollToBottom({double startY = 200, double endY = 600}) async {
    final gesture = await tester.startGesture(
      Offset(0, startY),
    ); //Position of the scrollview
    await gesture.moveBy(Offset(0, endY)); //How much to scroll by
    await tester.pump();
  }

  Future didScrollUntil(
    Finder finder, {
    Finder? scrollable,
    Offset moveStep = const Offset(0, -100),
    int maxIteration = 50,
    Duration duration = const Duration(milliseconds: 50),
  }) async {
    Finder view = scrollable ?? find.byType(Scrollable);

    return TestAsyncUtils.guard<void>(() async {
      while (maxIteration > 0 && finder.evaluate().isEmpty) {
        await tester.drag(view, moveStep, warnIfMissed: false);
        await tester.pump(duration);
        maxIteration -= 1;
      }
      await Scrollable.ensureVisible(tester.element(finder));
    });
  }

  Future<void> delay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  Future<void> awaitFinder(
    WidgetTester tester,
    Finder finder, {
    int maxWaitTime = 5000,
    int tickTime = 500,
  }) async {
    bool showText = false;
    int time = 0;
    while (!showText) {
      await delay(tickTime);
      // ignore: invalid_use_of_protected_member
      if (finder.allCandidates.isNotEmpty) {
        showText = true;
        return Future.value();
      }
      if (time > maxWaitTime) {
        showText = true;
        return Future.value();
      }
      time += tickTime;
    }
  }
}

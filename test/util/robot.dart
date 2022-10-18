import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

final sl = GetIt.instance;

abstract class Robot {
  static const deviseSizeDefault = Size(1440, 2560);
  final WidgetTester tester;
  late NavigatorObserver navigatorObserver;

  Robot(this.tester) {
    navigatorObserver = NavigatorObserverMock();
    registerFallbackValue(
      MaterialPageRoute<Widget>(builder: (_) => Container()),
    );
  }

  Future<void> widgetSetup(
    Widget widget, {
    Duration? awaitAnimation,
    Size? sizeScreen,
  }) async {
    tester.binding.window.physicalSizeTestValue =
        sizeScreen ?? deviseSizeDefault;
    await mockNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: widget,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [navigatorObserver],
          onGenerateRoute: (settings) {
            return MaterialPageRoute<Widget>(
              builder: (_) => Container(),
              settings: settings,
            );
          },
        ),
      );
      await awaitForAnimations(duration: awaitAnimation);
    });
    await awaitForAnimations(duration: awaitAnimation);
  }

  Future<void> awaitForAnimations({Duration? duration}) async {
    try {
      await tester.pumpAndSettle(duration ?? const Duration(milliseconds: 300));
    } catch (e) {
      await tester.pump(duration);
    }
  }

  Future takeSnapshot(String filename) {
    return expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('./golden_files/$filename.png'),
    );
  }

  Future resetDependencies() {
    return sl.reset();
  }

  void registerDependency<T extends Object>(T instance) {
    sl.registerSingleton(instance);
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

  Future loadImageAsset(String path) async {
    await tester.runAsync(() async {
      Element element = tester.element(find.byType(MaterialApp));
      await precacheImage(AssetImage(path), element);
      await tester.pumpAndSettle();
    });
  }

  Future waitPendingTimers(Duration duration) async {
    await tester.pump(duration);
  }

  void assetNavigate(String routeName) async {
    Route captured =
        verify(() => navigatorObserver.didPush(captureAny(), any()))
            .captured
            .last;

    expect(captured.settings.name, routeName);
  }
}

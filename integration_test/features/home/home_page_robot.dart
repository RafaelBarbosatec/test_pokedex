import 'package:flutter_test/flutter_test.dart';
import 'package:test_pokedex/core/di/injector.dart';

import '../../util/robot.dart';

class HomePageRobot extends Robot {
  String bulbasaurName = 'Bulbasaur';
  HomePageRobot(super.tester);

  Future configure() async {
    // Inject dependencies
    await Injector.reset();
    await Injector.bootstrap();
    await setupApp();
  }

  Future awaitShowBulbasaur() {
    return awaitFinder(tester, find.text(bulbasaurName).first);
  }

  Future didTapBulbasaur() {
    return tester.tap(find.text(bulbasaurName).first);
  }

  Future didScrollUtinShowEcans() {
    return didScrollUntil(find.text('Ekans'));
  }
}

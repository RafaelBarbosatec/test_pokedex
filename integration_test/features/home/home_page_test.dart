import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'home_page_robot.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('Should show list and click in bulbasaur', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.awaitShowBulbasaur();
    await robot.didTapBulbasaur();
    await robot.delay(2000);
  });

  testWidgets('Should show list and scroll', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.awaitShowBulbasaur();
    await robot.didScrollUtinShowEcans();
    await robot.delay(2000);
  });
}

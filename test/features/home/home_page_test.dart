import 'package:flutter_test/flutter_test.dart';

import 'home_page_robot.dart';

void main() {
  testWidgets('Should load screen', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.assetSnapshotLoadScreen();
  });

  testWidgets('Should load screen with error', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure(withError: true);
    await robot.assetSnapshotLoadScreenError();
  });

  testWidgets('Should load screen and go detail', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.didTapBulbasaur();
    robot.assetNavigate('/detail');
  });
}

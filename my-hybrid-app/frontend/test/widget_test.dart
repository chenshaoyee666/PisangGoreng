import 'package:flutter_test/flutter_test.dart';

import 'package:smartbite/main.dart';

void main() {
  testWidgets('SmartBite app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartBiteApp());

    expect(find.text('SmartBite'), findsOneWidget);
    expect(find.text('Continue as Sharer'), findsOneWidget);
  });
}

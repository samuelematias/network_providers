import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/widgets/alert_widget.dart';

extension on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}

void main() {
  group('AlertWidget', () {
    const defaultAlertIcon = Icons.home;
    const defaultAlertMessage = 'message!';
    const defaultAlertButtonLabel = 'my button';

    Widget _alertWidget({
      IconData alertIcon = defaultAlertIcon,
      String alertMessage = defaultAlertMessage,
      String alertButtonLabel = defaultAlertButtonLabel,
      VoidCallback? alertButtonOnPressed,
    }) {
      return AlertWidget(
        alertIcon: alertIcon,
        alertMessage: alertMessage,
        alertButtonLabel: alertButtonLabel,
        alertButtonOnPressed: alertButtonOnPressed,
      );
    }

    testWidgets('renders the widget', (tester) async {
      await tester.pumpApp(_alertWidget());

      expect(find.byType(AlertWidget), findsOneWidget);
    });

    testWidgets('renders the alertIcon', (tester) async {
      await tester.pumpApp(_alertWidget());

      expect(find.byIcon(defaultAlertIcon), findsOneWidget);
    });

    testWidgets('renders the alertMessage', (tester) async {
      await tester.pumpApp(_alertWidget());

      expect(find.text(defaultAlertMessage), findsOneWidget);
    });
    testWidgets('renders the alertButtonLabel', (tester) async {
      await tester.pumpApp(_alertWidget(alertButtonOnPressed: () {}));

      expect(find.text(defaultAlertButtonLabel), findsOneWidget);
    });
    testWidgets('renders the alertButton', (tester) async {
      await tester.pumpApp(_alertWidget(alertButtonOnPressed: () {}));

      expect(find.byType(TextButton), findsOneWidget);
    });
    testWidgets('assign a value in alertButtonOnPressed', (tester) async {
      late String value;
      const dog = 'dog';

      await tester.pumpApp(
        _alertWidget(
          alertButtonOnPressed: () {
            value = dog;
          },
        ),
      );

      await tester.tap(find.byType(TextButton));

      expect(value, dog);
    });
  });
}

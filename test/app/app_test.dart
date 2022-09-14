import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_providers/app/app.dart';
import 'package:search/search.dart';

class _MockNetworkProvidersRepository extends Mock
    implements NetworkProvidersRepository {}

void main() {
  group('App', () {
    late NetworkProvidersRepository repository;
    setUp(() {
      repository = _MockNetworkProvidersRepository();
    });
    testWidgets('renders NetworkProvidersListPage', (tester) async {
      await tester.pumpWidget(
        App(
          repository: repository,
        ),
      );
      await tester.pump(const Duration(milliseconds: 1100));
      expect(find.byType(NetworkProvidersListPage), findsOneWidget);
    });
  });
}

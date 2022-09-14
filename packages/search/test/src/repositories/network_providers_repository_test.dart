import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('NetworkProvidersRepository', () {
    late NetworkProvidersRepository repository;
    late List<NetworkProvidersModel> response;

    setUp(() async {
      repository = NetworkProvidersRepository();
      response = await repository.readJson();
    });
    group('readJson', () {
      test('check the first item', () async {
        expect(response.first.name, 'A+ Morumbi');
      });
      test('check the last item', () async {
        expect(response.last.name, 'a+ Vila Andrade');
      });
      test('check the list length', () async {
        expect(response.length, 59);
      });
    });
  });
}

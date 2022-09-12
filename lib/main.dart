import 'package:flutter/widgets.dart';
import 'package:network_providers/app/app.dart';
import 'package:network_providers/bootstrap.dart';
import 'package:search/search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final _repository = NetworkProvidersRepository();

  bootstrap(() {
    return App(
      repository: _repository,
    );
  });
}

import 'package:flutter/widgets.dart';
import 'package:network_providers/app/app.dart';
import 'package:network_providers/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}

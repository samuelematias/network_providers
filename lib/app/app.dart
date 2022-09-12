import 'package:flutter/material.dart';

/// {@template app}
/// The widget responsible for creating the [App].
/// {@endtemplate}
class App extends StatelessWidget {
  /// [App] class constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network search',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text('Hello!'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

/// {@template app}
/// The widget responsible for creating the [App].
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    super.key,
    required NetworkProvidersRepository repository,
  }) : _repository = repository;

  final NetworkProvidersRepository _repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _repository,
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Network providers',
      home: NetworkProvidersListPage(),
    );
  }
}

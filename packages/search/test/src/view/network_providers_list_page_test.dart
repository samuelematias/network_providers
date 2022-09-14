import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/src/cubit/network_providers_cubit.dart';
import 'package:search/src/models/models.dart';
import 'package:search/src/repositories/repositories.dart';
import 'package:search/src/view/view.dart';
import 'package:search/src/widgets/alert_widget.dart';

class _MockNetworkProvidersCubit extends MockCubit<NetworkProvidersState>
    implements NetworkProvidersCubit {}

class _FakeNetworkProvidersState extends Fake implements NetworkProvidersState {
}

class _MockNetworkProvidersRepository extends Mock
    implements NetworkProvidersRepository {}

extension on WidgetTester {
  Future<void> pumpListPage(NetworkProvidersRepository repository) {
    return pumpWidget(
      MaterialApp(
        home: RepositoryProvider.value(
          value: repository,
          child: const NetworkProvidersListPage(),
        ),
      ),
    );
  }

  Future<void> pumpListView(NetworkProvidersCubit listCubit) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: listCubit,
          child: const NetworkProvidersListView(),
        ),
      ),
    );
  }
}

void main() {
  late NetworkProvidersCubit networkProvidersCubit;
  late NetworkProvidersRepository networkProvidersRepository;

  setUpAll(() {
    registerFallbackValue(_FakeNetworkProvidersState());
  });

  setUp(() {
    networkProvidersCubit = _MockNetworkProvidersCubit();
    networkProvidersRepository = _MockNetworkProvidersRepository();
  });
  tearDown(() {
    networkProvidersCubit.close();
  });

  group('NetworkProvidersListPage', () {
    testWidgets(
      'renders NetworkProvidersListView',
      (tester) async {
        whenListen(
          networkProvidersCubit,
          Stream.value(
            const NetworkProvidersState.fetchSuccess(networkProvidersList: []),
          ),
          initialState: const NetworkProvidersState.initial(),
        );

        await tester.pumpListPage(networkProvidersRepository);

        await tester.pump();

        expect(find.byType(NetworkProvidersListView), findsOneWidget);
      },
    );
  });

  group('NetworkProvidersListView', () {
    const mockNetworkProviders = [
      NetworkProvidersModel(name: 'A+ Morumbi'),
      NetworkProvidersModel(name: 'Fleury - Avenida Brasil'),
      NetworkProvidersModel(name: 'a+ Vila Andrade'),
    ];
    testWidgets(
      'renders LoadingIndicator '
      'when state is loading',
      (tester) async {
        whenListen(
          networkProvidersCubit,
          Stream.value(
            const NetworkProvidersState.loading(),
          ),
          initialState: const NetworkProvidersState.initial(),
        );

        await tester.pumpListView(networkProvidersCubit);

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders the network providersList list '
      'when state is fetchSuccess',
      (tester) async {
        whenListen(
          networkProvidersCubit,
          Stream.value(
            const NetworkProvidersState.fetchSuccess(
              networkProvidersList: mockNetworkProviders,
            ),
          ),
          initialState: const NetworkProvidersState.initial(),
        );

        await tester.pumpListView(networkProvidersCubit);

        await tester.pump();

        expect(find.byType(ListTile), findsNWidgets(3));
      },
    );

    testWidgets(
      'renders the error state '
      'when state is fetchFailure',
      (tester) async {
        whenListen(
          networkProvidersCubit,
          Stream.value(
            const NetworkProvidersState.fetchFailure(),
          ),
          initialState: const NetworkProvidersState.initial(),
        );

        await tester.pumpListView(networkProvidersCubit);

        await tester.pump();

        expect(find.byType(AlertWidget), findsOneWidget);
      },
    );
  });
}

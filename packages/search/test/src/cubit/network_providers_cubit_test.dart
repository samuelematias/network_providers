import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/src/cubit/network_providers_cubit.dart';
import 'package:search/src/models/models.dart';
import 'package:search/src/repositories/repositories.dart';

class MockNetworkProvidersRepository extends Mock
    implements NetworkProvidersRepository {}

void main() {
  group('NetworkProvidersCubit', () {
    late NetworkProvidersRepository repository;
    setUp(() {
      repository = MockNetworkProvidersRepository();
    });
    test(
        'should initial state '
        'is NetworkProvidersState.initial', () {
      final networkProvidersCubit = NetworkProvidersCubit(repository);
      expect(
        networkProvidersCubit.state,
        const NetworkProvidersState.initial(),
      );
    });

    group('getNetworkProviders', () {
      const networkProviders = NetworkProvidersModel(name: 'doctor');
      setUp(() {
        when(
          () => repository.readJson(),
        ).thenAnswer(
          (_) async => Future<List<NetworkProvidersModel>>.value([]),
        );
      });
      blocTest<NetworkProvidersCubit, NetworkProvidersState>(
        'should invokes getNetworkProviders '
        'on repository',
        build: () => NetworkProvidersCubit(repository),
        act: (cubit) => cubit.getNetworkProviders(),
        verify: (_) {
          verify(() => repository.readJson()).called(1);
        },
      );

      blocTest<NetworkProvidersCubit, NetworkProvidersState>(
        'should emits [loading, success] '
        'when repository succeeds',
        build: () {
          when(
            () => repository.readJson(),
          ).thenAnswer(
            (_) async => Future<List<NetworkProvidersModel>>.value(
              [networkProviders],
            ),
          );
          return NetworkProvidersCubit(repository);
        },
        act: (cubit) => cubit.getNetworkProviders(),
        expect: () => const <NetworkProvidersState>[
          NetworkProvidersState.loading(),
          NetworkProvidersState.fetchSuccess(
            networkProvidersList: [networkProviders],
          ),
        ],
      );

      blocTest<NetworkProvidersCubit, NetworkProvidersState>(
        'should emits [loading, failure] '
        'when repository '
        'throws (defaultError)',
        build: () {
          when(
            () => repository.readJson(),
          ).thenThrow(Exception());
          return NetworkProvidersCubit(repository);
        },
        act: (cubit) => cubit.getNetworkProviders(),
        expect: () => const <NetworkProvidersState>[
          NetworkProvidersState.loading(),
          NetworkProvidersState.fetchFailure(),
        ],
      );
    });
  });
}

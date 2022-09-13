import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/cubit/network_providers_cubit.dart';
import 'package:search/src/models/models.dart';

void main() {
  group('NetworkProvidersState', () {
    test('support value comparisons', () {
      const mocknetworkProviders = [NetworkProvidersModel(name: 'doctor')];
      expect(
        const NetworkProvidersState.loading(),
        const NetworkProvidersState.loading(),
      );
      expect(
        const NetworkProvidersState.fetchFailure(),
        const NetworkProvidersState.fetchFailure(),
      );
      expect(
        const NetworkProvidersState.fetchSuccess(
          networkProvidersList: mocknetworkProviders,
        ),
        const NetworkProvidersState.fetchSuccess(
          networkProvidersList: mocknetworkProviders,
        ),
      );
    });
  });
}

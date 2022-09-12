import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search/src/models/models.dart';
import 'package:search/src/repositories/repositories.dart';

part 'network_providers_state.dart';

/// {@template network_providers_cubit}
/// A cubit that handle the business logic.
/// {@endtemplate}
class NetworkProvidersCubit extends Cubit<NetworkProvidersState> {
  /// {@macro network_providers_cubit}
  NetworkProvidersCubit(this._repository)
      : super(const NetworkProvidersState.initial());

  final NetworkProvidersRepository _repository;

  /// Return the list of the network provider.
  Future<void> getNetworkProviders() async {
    try {
      emit(const NetworkProvidersState.loading());
      final response = await _repository.readJson();
      emit(
        NetworkProvidersState.fetchSuccess(networkProvidersList: response),
      );
    } catch (e) {
      emit(
        const NetworkProvidersState.fetchFailure(),
      );
    }
  }

  /// On changed method to textfield.
  /// Returning a filtered list of network providers by what was typed.
  void onChanged(String value) {
    final list = state.networkProvidersList.where(
      (e) {
        return e.name.toString().startsWith(value);
      },
    ).toList();
    emit(
      state.copyWith(
        networkProvidersListSearched: list,
        isSearchBarNotEmpty: value.isNotEmpty,
        typedContent: value,
      ),
    );
  }
}

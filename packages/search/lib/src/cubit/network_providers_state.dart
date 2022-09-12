part of 'network_providers_cubit.dart';

/// Enum with possible errors types.
enum ErrorType {
  /// For an unexpected error.
  defaultError,

  /// If no error occurs.
  none,
}

/// {@template network_providers_state}
/// Handle the entire [NetworkProvidersState].
/// {@endtemplate}
class NetworkProvidersState extends Equatable {
  /// {@macro network_providers_state}
  const NetworkProvidersState({
    this.isLoading = false,
    this.isSearchBarNotEmpty = false,
    this.typedContent = '',
    this.networkProvidersList = const <NetworkProvidersModel>[],
    this.networkProvidersListSearched = const <NetworkProvidersModel>[],
    this.errorType = ErrorType.none,
  });

  /// Initial state of [NetworkProvidersState].
  const NetworkProvidersState.initial()
      : this(
          isLoading: false,
          isSearchBarNotEmpty: false,
          typedContent: '',
          networkProvidersList: const <NetworkProvidersModel>[],
          networkProvidersListSearched: const <NetworkProvidersModel>[],
          errorType: ErrorType.none,
        );

  /// Loading state of [NetworkProvidersState].
  const NetworkProvidersState.loading({
    String typedContent = '',
    List<NetworkProvidersModel> networkProvidersList =
        const <NetworkProvidersModel>[],
    List<NetworkProvidersModel> networkProvidersListSearched =
        const <NetworkProvidersModel>[],
  }) : this(
          isLoading: true,
          isSearchBarNotEmpty: false,
          typedContent: typedContent,
          networkProvidersList: networkProvidersList,
          networkProvidersListSearched: networkProvidersListSearched,
          errorType: ErrorType.none,
        );

  /// Fetching the API give an error state of [NetworkProvidersState].
  const NetworkProvidersState.fetchFailure({
    String typedContent = '',
    List<NetworkProvidersModel> networkProvidersList =
        const <NetworkProvidersModel>[],
    List<NetworkProvidersModel> networkProvidersListSearched =
        const <NetworkProvidersModel>[],
    ErrorType errorType = ErrorType.defaultError,
  }) : this(
          isLoading: false,
          isSearchBarNotEmpty: false,
          typedContent: typedContent,
          networkProvidersList: networkProvidersList,
          networkProvidersListSearched: networkProvidersListSearched,
          errorType: errorType,
        );

  /// Fetching the API was success state of [NetworkProvidersState].
  const NetworkProvidersState.fetchSuccess({
    String typedContent = '',
    required List<NetworkProvidersModel> networkProvidersList,
    List<NetworkProvidersModel> networkProvidersListSearched =
        const <NetworkProvidersModel>[],
  }) : this(
          isLoading: false,
          isSearchBarNotEmpty: false,
          typedContent: typedContent,
          networkProvidersList: networkProvidersList,
          networkProvidersListSearched: networkProvidersListSearched,
          errorType: ErrorType.none,
        );

  /// copyWith method for the [NetworkProvidersState].
  NetworkProvidersState copyWith({
    bool? isLoading,
    bool? isSearchBarNotEmpty,
    String? typedContent,
    List<NetworkProvidersModel>? networkProvidersList,
    List<NetworkProvidersModel>? networkProvidersListSearched,
    ErrorType? errorType,
  }) {
    return NetworkProvidersState(
      isLoading: isLoading ?? this.isLoading,
      isSearchBarNotEmpty: isSearchBarNotEmpty ?? this.isSearchBarNotEmpty,
      typedContent: typedContent ?? this.typedContent,
      networkProvidersList: networkProvidersList ?? this.networkProvidersList,
      networkProvidersListSearched:
          networkProvidersListSearched ?? this.networkProvidersListSearched,
      errorType: errorType ?? this.errorType,
    );
  }

  /// If is true, indicates that request to API is loading.
  ///
  /// If is false, indicates that request to API was finished.
  final bool isLoading;

  /// If is true, indicates that a value was typed in the TextField.
  ///
  /// If is false, indicates that a value was not typed yet in the TextField.
  final bool isSearchBarNotEmpty;

  /// The content that was typed.
  final String typedContent;

  /// The network providers list that was received from the json.
  final List<NetworkProvidersModel> networkProvidersList;

  /// The network providers found by search.
  final List<NetworkProvidersModel> networkProvidersListSearched;

  /// If has some error in the process.
  final ErrorType errorType;

  @override
  List<Object> get props => [
        isLoading,
        isSearchBarNotEmpty,
        typedContent,
        networkProvidersList,
        networkProvidersListSearched,
        errorType,
      ];
}

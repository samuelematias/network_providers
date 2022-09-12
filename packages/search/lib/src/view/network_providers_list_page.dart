import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

/// {@template network_providers_list_page}
/// The page responsabilite to render the list of movies.
/// {@endtemplate}
class NetworkProvidersListPage extends StatelessWidget {
  /// {@macro network_providers_list_page}
  const NetworkProvidersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NetworkProvidersCubit(
        context.read<NetworkProvidersRepository>(),
      )..getNetworkProviders(),
      child: const _NetworkProvidersListView(),
    );
  }
}

class _NetworkProvidersListView extends StatelessWidget {
  const _NetworkProvidersListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Colors.white,
              bottom: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      onChanged:
                          context.read<NetworkProvidersCubit>().onChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search for Network providers',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                BlocBuilder<NetworkProvidersCubit, NetworkProvidersState>(
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _NetworkProvidersListState(
                            state: state,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkProvidersListState extends StatelessWidget {
  const _NetworkProvidersListState({
    required this.state,
  });
  final NetworkProvidersState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const CircularProgressIndicator.adaptive();
    } else if (state.networkProvidersList.isNotEmpty) {
      final networkProvidersNotFoundBySearch = state.isSearchBarNotEmpty &&
          state.networkProvidersListSearched.isEmpty;
      final networkProvidersList = state.networkProvidersListSearched.isEmpty &&
              !state.isSearchBarNotEmpty
          ? state.networkProvidersList
          : state.networkProvidersListSearched;

      return _NetworkProvidersList(
        networkProvidersNotFoundBySearch: networkProvidersNotFoundBySearch,
        networkProvidersList: networkProvidersList,
      );
    } else if (state.errorType == ErrorType.defaultError) {
      return const AlertWidget(
        alertIcon: Icons.error,
        alertMessage: 'Ops, Something is wrong!',
      );
    }

    return const SizedBox.shrink();
  }
}

class _NetworkProvidersList extends StatelessWidget {
  const _NetworkProvidersList({
    required this.networkProvidersNotFoundBySearch,
    required this.networkProvidersList,
  });

  final bool networkProvidersNotFoundBySearch;
  final List<NetworkProvidersModel> networkProvidersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: networkProvidersNotFoundBySearch
              ? const AlertWidget(
                  alertIcon: Icons.error,
                  alertMessage: 'Ops, nothing found!',
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: networkProvidersList.length,
                  itemBuilder: (_, index) {
                    final networkProviders = networkProvidersList[index];
                    return ListTile(
                      title: Text(networkProviders.name!),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// {@template alert_widget}
/// The page responsabilite to render the list of movies.
/// {@endtemplate}
class AlertWidget extends StatelessWidget {
  /// {@macro alert_widget}
  const AlertWidget({
    super.key,
    required this.alertIcon,
    required this.alertMessage,
    this.alertButtonLabel = '',
    this.alertButtonOnPressed,
  });

  /// The icon data for the alert.
  final IconData alertIcon;

  /// The text for the alert.
  final String alertMessage;

  /// The text label for the alert button.
  final String alertButtonLabel;

  /// The on pressed function for the alert button.
  /// can be null.
  final VoidCallback? alertButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final showAlertButton =
        alertButtonOnPressed != null && alertButtonLabel.isNotEmpty;
    return Column(
      children: [
        Icon(
          alertIcon,
          size: 40,
        ),
        const SizedBox(height: 16),
        Text(alertMessage),
        if (showAlertButton) ...[
          TextButton(
            onPressed: alertButtonOnPressed,
            child: Text(alertButtonLabel),
          )
        ]
      ],
    );
  }
}

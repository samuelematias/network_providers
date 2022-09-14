import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:search/src/widgets/widgets.dart';

/// {@template network_providers_list_page}
/// The page responsabilite to render
/// the list of network providers.
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
      child: const NetworkProvidersListView(),
    );
  }
}

/// {@template network_providers_list_view}
/// The view responsabilite to render
/// the list of network providers.
/// {@endtemplate}
class NetworkProvidersListView extends StatelessWidget {
  /// {@macro network_providers_list_view}
  const NetworkProvidersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            return CustomScrollView(
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
                                minWidth: constraints.maxWidth,
                                minHeight: 50 /
                                    100 *
                                    MediaQuery.of(context).size.height,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NetworkProvidersListState extends StatelessWidget {
  const _NetworkProvidersListState({
    required this.state,
    required this.minWidth,
    required this.minHeight,
  });

  final NetworkProvidersState state;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return _CenterWidgetInsideSingleChildScrollView(
        minWidth: minWidth,
        minHeight: minHeight,
        child: const CircularProgressIndicator.adaptive(),
      );
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
        minWidth: minWidth,
        minHeight: minHeight,
      );
    } else if (state.errorType == ErrorType.defaultError) {
      return _CenterWidgetInsideSingleChildScrollView(
        minWidth: minWidth,
        minHeight: minHeight,
        child: AlertWidget(
          alertIcon: Icons.error,
          alertMessage: 'Ops, Something is wrong!',
          alertButtonLabel: 'Try again',
          alertButtonOnPressed: () =>
              context.read<NetworkProvidersCubit>().getNetworkProviders(),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _NetworkProvidersList extends StatelessWidget {
  const _NetworkProvidersList({
    required this.networkProvidersNotFoundBySearch,
    required this.networkProvidersList,
    required this.minWidth,
    required this.minHeight,
  });

  final bool networkProvidersNotFoundBySearch;
  final List<NetworkProvidersModel> networkProvidersList;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: networkProvidersNotFoundBySearch
              ? _CenterWidgetInsideSingleChildScrollView(
                  minWidth: minWidth,
                  minHeight: minHeight,
                  child: const AlertWidget(
                    alertIcon: Icons.error,
                    alertMessage: 'Ops, nothing found!',
                  ),
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

class _CenterWidgetInsideSingleChildScrollView extends StatelessWidget {
  const _CenterWidgetInsideSingleChildScrollView({
    required this.minWidth,
    required this.minHeight,
    required this.child,
  });

  final double minWidth;
  final double minHeight;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      child: Center(child: child),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wldd/core/hive_support.dart';
import 'package:wldd/features/developers/model/offline_user_model.dart';
import 'package:wldd/resources/styles/colors_class.dart';
import 'package:wldd/resources/widgets/app_text.dart';
import 'package:wldd/resources/widgets/text_field_widget.dart';
import '../bloc/user_bloc/users_bloc.dart';
import '../bloc/user_bloc/users_event.dart';
import '../bloc/user_bloc/users_state.dart';
import '../cubit/search_cubit.dart';
import '../fav_cubit/favorite_state.dart';
import '../fav_cubit/favorites_cubit.dart';
import '../widgets/developer_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  /// Load data on start
  Future<void> _loadInitialData() async {
    final userBox = Hive.box<OfflineUserModel>(HiveSupport.userBoxName);
    if (userBox.isEmpty) {
      setState(() => _isOnline = true);
      context.read<UsersBloc>().add(GetUsersEvent());
    } else {
      setState(() => _isOnline = false);
    }

    // Load favorites when app starts
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<OfflineUserModel>(HiveSupport.userBoxName);
    final offlineUsers = userBox.values.toList();

    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state.userStatus == UserStatus.loaded) {
          setState(() => _isOnline = true);
        }
      },
      builder: (context, state) {
        final isLoading = state.userStatus == UserStatus.loading;

        return BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            final onlineList = searchState.query.isEmpty
                ? state.usersList
                : searchState.filteredOnlineUsers;

            final offlineList = searchState.query.isEmpty
                ? offlineUsers
                : searchState.filteredOfflineUsers;

            return Scaffold(
              backgroundColor: Palette.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Palette.white,
                title: AppTextField(
                  borderRadius: 12,
                  hintText: 'Search developers...',
                  prefixWidget:
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  onChanged: (query) {
                    if (_isOnline) {
                      context
                          .read<SearchCubit>()
                          .searchOnline(query, state.usersList);
                    } else {
                      context
                          .read<SearchCubit>()
                          .searchOffline(query, offlineUsers);
                    }
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // 🟢 Status Banner
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _isOnline
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isOnline ? Colors.green : Colors.orange,
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isOnline
                                ? Icons.wifi_rounded
                                : Icons.wifi_off_rounded,
                            color: _isOnline ? Colors.green : Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          AppText(
                            _isOnline ? "Online data" : "Offline data",
                            color: _isOnline ? Colors.green : Colors.orange,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: RefreshIndicator(
                        backgroundColor: Palette.kPrimary,
                        color: Palette.white,
                        onRefresh: () async {
                          setState(() => _isOnline = true);
                          context.read<UsersBloc>().add(GetUsersEvent());
                          await context.read<FavoritesCubit>().loadFavorites();
                        },
                        child: BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, favState) {
                            final favCubit = context.read<FavoritesCubit>();

                            return CustomScrollView(
                              slivers: [
                                if (!_isOnline && offlineList.isNotEmpty)
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        final user = offlineList[index];
                                        final userId = user.id.toString();

                                        return DeveloperListCard(
                                          avatarUrl: user.imageUrl,
                                          name: user.name,
                                          username: user.name,
                                          bio: user.url,
                                          isFavorite:
                                          favCubit.isFavorite(userId),
                                          onTap: () {
                                            context.pushNamed(
                                              'developerDetails',
                                              extra: {'name': user.name},
                                            );
                                          },
                                          onFavoriteToggle: () async {
                                            await favCubit
                                                .toggleFavorite(userId);
                                          },
                                        );
                                      },
                                      childCount: offlineList.length,
                                    ),
                                  )
                                else if (isLoading)
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                          (context, index) => Skeletonizer(
                                        enabled: true,
                                        child: DeveloperListCard(
                                          avatarUrl:
                                          "https://avatars.githubusercontent.com/u/1?v=4",
                                          name: "Loading...",
                                          username: "loading",
                                          bio: "loading...",
                                          isFavorite: false,
                                          onTap: () {},
                                          onFavoriteToggle: () {},
                                        ),
                                      ),
                                      childCount: 8,
                                    ),
                                  )
                                else if (onlineList.isEmpty)
                                    SliverToBoxAdapter(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 100),
                                        child: Center(
                                          child: AppText(
                                            "No developers found",
                                            color: Palette.textMuted,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          final user = onlineList[index];
                                          final userId = user.id.toString();

                                          return DeveloperListCard(
                                            avatarUrl: user.avatarUrl ??
                                                "https://avatars.githubusercontent.com/u/1?v=4",
                                            name: user.login ?? "",
                                            username: user.login ?? "",
                                            bio: user.htmlUrl ?? "",
                                            isFavorite:
                                            favCubit.isFavorite(userId),
                                            onTap: () {
                                              context.pushNamed(
                                                'developerDetails',
                                                extra: {'name': user.login},
                                              );
                                            },
                                            onFavoriteToggle: () async {
                                              await favCubit
                                                  .toggleFavorite(userId);
                                            },
                                          );
                                        },
                                        childCount: onlineList.length,
                                      ),
                                    ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

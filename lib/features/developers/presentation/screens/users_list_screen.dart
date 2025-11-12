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
import '../../../../resources/widgets/sliver_height.dart';
import '../bloc/user_bloc/users_bloc.dart';
import '../bloc/user_bloc/users_event.dart';
import '../bloc/user_bloc/users_state.dart';
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

  Future<void> _loadInitialData() async {
    final userBox = Hive.box<OfflineUserModel>(HiveSupport.userBoxName);

    if (userBox.isEmpty) {
      setState(() => _isOnline = true);
      context.read<UsersBloc>().add(GetUsersEvent());
    } else {
      setState(() => _isOnline = false);
    }
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

        return Scaffold(
          backgroundColor: Palette.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RefreshIndicator(
              backgroundColor: Palette.kPrimary,
              color: Palette.white,
              onRefresh: () async {
                setState(() => _isOnline = true);
                context.read<UsersBloc>().add(GetUsersEvent());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Palette.white,
                    pinned: false,
                    title: AppText(
                      "Developers",
                      color: Palette.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SliverH20(),

                  // 🟢 Banner
                  SliverToBoxAdapter(
                    child: Container(
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
                  ),

                  // 🟠 OFFLINE LIST
                  if (!_isOnline && offlineUsers.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final user = offlineUsers[index];
                          return DeveloperListCard(
                            avatarUrl: user.imageUrl,
                            name: user.name,
                            username: user.name,
                            bio: user.url,
                            isFavorite: false,
                            onTap: () {
                              context.pushNamed(
                                'developerDetails',
                                extra: {'name': user.name},
                              );
                            },
                            onFavoriteToggle: () {
                              log("Fav toggled for offline user: ${user.name}");
                            },
                          );
                        },
                        childCount: offlineUsers.length,
                      ),
                    ),
                  ]

                  // 🟢 ONLINE LIST (with Skeletonizer)
                  else ...[
                    if (isLoading)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return Skeletonizer(
                              enabled: true,
                              child: DeveloperListCard(
                                avatarUrl:
                                "https://avatars.githubusercontent.com/u/1?v=4",
                                name: "Loading...",
                                username: "loading",
                                bio: "loading...",
                                isFavorite: false,
                                onTap: () {},
                              ),
                            );
                          },
                          childCount: 8,
                        ),
                      )
                    else if (state.usersList.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: AppText(
                              "No users found online",
                              color: Palette.textMuted,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final user = state.usersList[index];
                            return DeveloperListCard(
                              avatarUrl: user.avatarUrl ??
                                  "https://avatars.githubusercontent.com/u/1?v=4",
                              name: user.login ?? "",
                              username: user.login ?? "",
                              bio: user.htmlUrl ?? "",
                              isFavorite: false,
                              onTap: () {
                                context.pushNamed(
                                  'developerDetails',
                                  extra: {'name': user.login},
                                );
                              },
                              onFavoriteToggle: () {
                                log("Fav toggled for online user: ${user.login}");
                              },
                            );
                          },
                          childCount: state.usersList.length,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

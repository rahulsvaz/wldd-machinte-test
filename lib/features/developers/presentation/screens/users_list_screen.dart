import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wldd/resources/styles/colors_class.dart';
import 'package:wldd/resources/widgets/text_field_widget.dart';

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
  @override
  void initState() {
    super.initState();

    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.white,

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RefreshIndicator(
              backgroundColor: Palette.kPrimary,
              color: Palette.white,
              onRefresh: () async {
                context.read<UsersBloc>().add(GetUsersEvent());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Palette.white,
                    pinned: false,
                    title: AppTextField(borderRadius: 12, hintText: "Search"),
                  ),
                  SliverH20(),

                  BlocConsumer<UsersBloc, UsersState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.usersList.isEmpty) {
                        return SliverToBoxAdapter(child: Container());
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final user = state.usersList[index];

                            return Skeletonizer(
                              enabled: state.userStatus == UserStatus.loading,
                              child: DeveloperListCard(
                                avatarUrl:
                                    user.avatarUrl ??
                                    "https://avatars.githubusercontent.com/u/1?v=4",
                                name: user.login ?? "",
                                username: user.login ?? "",
                                bio: user.htmlUrl,
                                isFavorite: false,
                                onTap: () {
                                  context.pushNamed(
                                    'developerDetails',
                                    extra: {'name': user.login},
                                  );
                                },

                                onFavoriteToggle: () {
                                  log("fv");
                                  // Toggle favorite status
                                },
                              ),
                            );
                          }, childCount: 10),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

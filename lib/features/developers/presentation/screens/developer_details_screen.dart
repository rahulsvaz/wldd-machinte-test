import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wldd/features/developers/presentation/bloc/user_repo_bloc/user_repo_bloc.dart';
import 'package:wldd/features/developers/repository/repository_repo_impl.dart';
import '../../../../resources/styles/colors_class.dart';
import '../../../../resources/styles/text_style_class.dart';
import '../../../../resources/widgets/app_text.dart';
import '../bloc/user_details_bloc/user_details_bloc.dart';

class DeveloperDetailsScreen extends StatefulWidget {
  final String name;

  const DeveloperDetailsScreen({
    super.key,
    required this.name,
  });

  @override
  State<DeveloperDetailsScreen> createState() => _DeveloperDetailsScreenState();
}

class _DeveloperDetailsScreenState extends State<DeveloperDetailsScreen>
    with TickerProviderStateMixin {
  void _openWebView(BuildContext context, String url) {
    context.push('/webview', extra: url);
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().add(GetUserDetailsEvent(url: widget.name));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRepoBloc(RepositoryRepoImpl()),
      child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          final user = state.userDetails;

          return Skeletonizer(
            enabled: state.userDetailsStatus == UserDetailsStatus.loading,
            child: Scaffold(
              backgroundColor: Palette.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Palette.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Palette.textPrimary),
                  onPressed: () => context.pop(),
                ),
                title: AppText(
                  widget.name,
                  style: Styles.roboto16Bold,
                  color: Palette.textPrimary,
                ),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 20),

                  // Avatar + user info
                  _buildProfileSection(user),

                  const SizedBox(height: 16),

                  // Tab bar for repos
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.blue.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Palette.blue, Palette.purpleLight],
                        ),
                      ),
                      labelColor: Palette.white,
                      unselectedLabelColor: Palette.textMuted,
                      tabs: const [
                        Tab(text: 'Public Repos'),
                        Tab(text: 'Private Repos'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Tab views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Ct(
                          name: widget.name,
                          isPrivate: false,
                        ),
                        Ct(
                          name: widget.name,
                          isPrivate: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(user) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Palette.blue, Palette.purpleLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Palette.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: CachedNetworkImage(
                imageUrl: user?.avatarUrl ?? "",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                placeholder: (context, url) =>
                const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) =>
                const Icon(Icons.person, size: 50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        AppText(
          user?.name ?? "",
          style: Styles.roboto18Bold,
          color: Palette.textPrimary,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 4),

        AppText(
          "@${widget.name}",
          style: Styles.roboto14,
          color: Palette.blue,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        if (user?.location != null && user!.location!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 16, color: Palette.textMuted),
              const SizedBox(width: 4),
              AppText(
                user.location ?? "",
                style: Styles.roboto12,
                color: Palette.textMuted,
              ),
            ],
          ),

        const SizedBox(height: 16),

        if (user?.blog != null && user!.blog!.isNotEmpty)
          GestureDetector(
            onTap: () => _openWebView(context, user.blog!),
            child: AppText(
              user.blog!,
              style: Styles.roboto12Medium.copyWith(fontSize: 13),
              color: Palette.blue,
              textAlign: TextAlign.center,
            ),
          ),

        const SizedBox(height: 24),

        // Stats
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Palette.blueBaby.withOpacity(0.25),
                Palette.purpleLavender.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Palette.borderGrey.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Palette.blue.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat("Followers", "${user?.followers ?? 0}"),
              _buildStat("Following", "${user?.following ?? 0}"),
              _buildStat("Repos", "${user?.publicRepos ?? 0}"),
              _buildStat("Gists", "${user?.publicGists ?? 0}"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        AppText(
          value,
          style: Styles.roboto16Bold,
          color: Palette.textPrimary,
        ),
        const SizedBox(height: 4),
        AppText(
          label,
          style: Styles.roboto12,
          color: Palette.textMuted,
        ),
      ],
    );
  }
}

class Ct extends StatefulWidget {
  final String name;
  final bool isPrivate;
  const Ct({super.key, required this.name, required this.isPrivate});

  @override
  State<Ct> createState() => _CtState();
}

class _CtState extends State<Ct> {
  @override
  void initState() {
    context.read<UserRepoBloc>().add(GetUserRepoEvent(url: widget.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRepoBloc, UserRepoState>(
      builder: (context, state) {
        if (state.status == UserRepoStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == UserRepoStatus.empty) {
          return const Center(child: Text("No repositories found"));
        }

        final repoList = state.repoList
            .where((repo) {
          final isPrivate = repo.private ?? false;
          return widget.isPrivate ? isPrivate : !isPrivate;
        })
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: repoList.length,
          itemBuilder: (context, index) {
            final repo = repoList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.blueBaby.withOpacity(0.15),
                    Palette.purpleLavender.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Palette.borderGrey.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: Palette.blue.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    repo.name??"",
                    style: Styles.roboto16Bold,
                    color: Palette.textPrimary,
                  ),
                  const SizedBox(height: 4),
                  if (repo.description != null && repo.description!.isNotEmpty)
                    AppText(
                      repo.description!,
                      style: Styles.roboto12,
                      color: Palette.textMuted,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      AppText(
                        "${repo.stargazersCount}",
                        style: Styles.roboto12,
                        color: Palette.textPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

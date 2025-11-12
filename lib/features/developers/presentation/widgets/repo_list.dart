



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../resources/styles/colors_class.dart';
import '../../../../resources/styles/text_style_class.dart';
import '../../../../resources/widgets/app_text.dart';
import '../bloc/user_repo_bloc/user_repo_bloc.dart';

class RepoList extends StatefulWidget {
  final String name;
  final bool isPrivate;
  const RepoList({super.key, required this.name, required this.isPrivate});
  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  @override
  void initState() {
    super.initState();
    context.read<UserRepoBloc>().add(GetUserRepoEvent(url: widget.name));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRepoBloc, UserRepoState>(
      builder: (context, state) {
        final isLoading = state.status == UserRepoStatus.loading;
        final repoList = state.repoList
            .where((repo) {
          final isPrivate = repo.private ?? false;
          return widget.isPrivate ? isPrivate : !isPrivate;
        })
            .toList();
        if (state.status == UserRepoStatus.empty && !isLoading) {
          return const Center(child: Text("No repositories found"));
        }
        return Skeletonizer(
          enabled: isLoading,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: isLoading ? 6 : repoList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final repo = isLoading ? null : repoList[index];
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Palette.borderGrey.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.blue.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      repo?.name ?? "Loading repository...",
                      style: Styles.roboto16Bold,
                      color: Palette.textPrimary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      repo?.description?.isNotEmpty == true
                          ? repo!.description!
                          : "No description provided.",
                      style: Styles.roboto12,
                      color: Palette.textMuted,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        AppText(
                          "${repo?.stargazersCount ?? 0}",
                          style: Styles.roboto12,
                          color: Palette.textPrimary,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
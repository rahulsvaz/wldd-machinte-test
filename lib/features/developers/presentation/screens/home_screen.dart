import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wldd/resourses/styles/colors_class.dart';
import 'package:wldd/resourses/widgets/text_field_widget.dart';

import '../../../../resourses/widgets/sliver_height.dart';
import '../widgets/developer_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Palette.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Palette.white,
                pinned: false,
                title: AppTextField(
                    borderRadius: 12,
                    hintText: "Search")),
            SliverH20(),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return  DeveloperListCard(
                  avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
                  name: 'Tom Preston-Werner',
                  username: 'mojombo',
                  bio: 'Co-founder of GitHub, creator of Jekyll',
                  isFavorite: false,
                  onTap: () {
                    log("rr");

                    // Navigate to detail screen
                  },
                  onFavoriteToggle: () {
                    log("fv");
                    // Toggle favorite status
                  },
                );
              }, childCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}



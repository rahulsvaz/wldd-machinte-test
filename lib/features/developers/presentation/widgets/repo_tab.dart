
import 'package:flutter/material.dart';

import '../../../../resources/styles/colors_class.dart';
import '../../../../resources/styles/text_style_class.dart';

class RepoTab extends StatefulWidget {
 final TabController controller;
  const RepoTab({super.key,required this.controller});

  @override
  State<RepoTab> createState() => _RepoTabState();
}

class _RepoTabState extends State<RepoTab> {
  @override
  Widget build(BuildContext context) {
    return    Container(
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
        child: Container(
          height: 46,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Palette.blue.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TabBar(
            controller: widget.controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Palette.blue, Palette.purpleLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            indicatorColor: Colors.transparent,
            labelColor: Palette.white,
            unselectedLabelColor: Palette.textMuted,
            labelStyle: Styles.roboto14Bold,
            unselectedLabelStyle: Styles.roboto14,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            tabs: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(text: 'Public Repos'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(text: 'Private Repos'),
              ),
            ],
          ),
        )

    );
  }
}

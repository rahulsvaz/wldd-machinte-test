

import 'package:flutter/material.dart';

class SliverH20 extends StatelessWidget {
  const SliverH20({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: 20,),);
  }
}

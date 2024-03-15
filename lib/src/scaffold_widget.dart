import 'package:flutter/material.dart';

import 'drawer.dart';

class ScaffoldWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  const ScaffoldWidget(this.title, this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: widget,
    );
  }
}

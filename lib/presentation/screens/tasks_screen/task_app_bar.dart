import 'package:flutter/material.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0,),
            icon: const Icon(
              Icons.account_circle_sharp,
              size: 24,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
          icon: const Icon(
            Icons.search,
            size: 24,),
          onPressed: () {},
        )
      ],
    );
  }
}
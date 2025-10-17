import 'package:elyx_digital_user_app/features/users/models/user_model.dart';
import 'package:flutter/material.dart';

import 'user_tile.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> usersList;
  final ScrollController scrollCtrler;
  const UserListView({
    super.key,
    required this.usersList,
    required this.scrollCtrler,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      controller: scrollCtrler,
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        return UserTile(user: usersList[index]);
      },
    );
  }
}

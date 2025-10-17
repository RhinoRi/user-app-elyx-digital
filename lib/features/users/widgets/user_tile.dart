import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/shared_widgets/network_image_display.dart';
import '../models/user_model.dart';
import '../screens/user_details_screen.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        decoration: BoxDecoration(
          color: appSecondaryColor,
          borderRadius: BorderRadius.circular(16), // 👈 Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailsScreen(user: user),
                ),
              );
            },
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: appPrimaryColor, width: 2.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: displayNetworkImage(imageUrl: user.userImage!),
                ),
              ),
              title: Text(
                "${user.firstName!} ${user.lastName!}",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
              ),
              // trailing: Text(user.id.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

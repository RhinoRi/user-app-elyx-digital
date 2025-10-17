import 'package:elyx_digital_user_app/core/constants/app_colors.dart';
import 'package:elyx_digital_user_app/core/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/network_image_display.dart';
import '../models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: appPrimaryColor),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [userAvatar(context), userDetails(context)],
        ),
      ),
    );
  }

  Widget userAvatar(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: ctx.screenHeight / 2,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: displayNetworkImage(
            imageUrl: user.userImage!,
            isDetailScreen: true,
          ),
        ),
      ),
    );
  }

  Widget userDetails(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${user.firstName!} ${user.lastName!}",
            style: Theme.of(ctx).textTheme.titleLarge,
          ),
          Text(
            user.email!,
            style: Theme.of(
              ctx,
            ).textTheme.titleSmall!.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

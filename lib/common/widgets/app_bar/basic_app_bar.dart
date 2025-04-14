import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onNotificationsPressed;
  final bool centerTitle;
  final String title;
  const BasicAppBar({super.key, required this.onNotificationsPressed, this.centerTitle = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: centerTitle,
      leading: 0.horizontalSpace,
      leadingWidth: 1.w,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        IconButton(
          onPressed: onNotificationsPressed,
          icon: SvgPicture.asset(
            AppVectors.notificationBell,
            width: 30.r,
          ),
        ),
        10.horizontalSpace,
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

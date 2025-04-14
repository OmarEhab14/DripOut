import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(onNotificationsPressed: () {}, title: 'Saved Items',),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppVectors.noSavedItemsIcon, width: 70.r,),
            10.verticalSpace,
            Text('No Saved Items!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
            10.verticalSpace,
            const Text('You don\'t have any saved items.'),
            const Text('Go to home and add some.'),
          ],
        ),
      ),
    );
  }
}

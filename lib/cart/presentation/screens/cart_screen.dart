import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(onNotificationsPressed: () {}, title: 'My Cart',),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppVectors.emptyCartIcon, width: 70.r,),
            10.verticalSpace,
            Text('Your cart is empty!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
            10.verticalSpace,
            const Text('When you add products, they\'ll'),
            const Text('appear here.'),
          ],
        ),
      ),
    );
  }
}

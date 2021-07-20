import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wan_android_getx/const/constants.dart';

class AppBarIcon extends StatelessWidget {
  final String assetName;
  final VoidCallback onTap;

  const AppBarIcon({required this.assetName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30.r,
        width: 30.r,
        padding: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: context.accentColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SvgPicture.asset(
          assetName,
          color: context.accentColor,
        ),
      ),
    );
  }
}

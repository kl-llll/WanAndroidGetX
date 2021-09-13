import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/app/local/local_login.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/custom_neumorphic.dart';
import 'controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(20),
              color: context.canvasColor,
              height: 250.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        "用户登录",
                        style: TextStyle(
                            color: context.accentColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    _buildTextField(controller.userNameController, "账号"),
                    SizedBox(height: 20.h),
                    _buildTextField(controller.userPwdController, "密码"),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 50,
          child: _buildArgonButton(context),
        ),
      ],
    );
  }

  Widget _buildArgonButton(BuildContext context) {
    return ArgonButton(
      height: 55.r,
      roundLoadingShape: true,
      width: 55.r,
      onTap: (startLoading, stopLoading, btnState) {
        if (btnState == ButtonState.Idle) {
          controller.login(startLoading, stopLoading);
        } else {
          stopLoading();
        }
      },
      child: Icon(
        CupertinoIcons.checkmark_alt,
        color: Colors.white,
        size: 30,
      ),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: LoadingState(),
      ),
      borderRadius: 99,
      color: context.accentColor,
    );
  }

  Container _buildTextField(
      TextEditingController controller, String labelText) {
    return Container(
      height: 50.h,
      child: TextField(
        controller: controller,
        obscureText: labelText == "密码" ? true : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
        ),
      ),
    );
  }
}

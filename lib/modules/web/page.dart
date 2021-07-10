import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'controller.dart';

class WebPage extends StatelessWidget {
  final controller = Get.find<WebController>();

  Widget _appBar(BuildContext context) {
    Widget icon(String assetName, VoidCallback onTap) {
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

    return Column(
      children: [
        Container(
          color: context.canvasColor,
          padding: EdgeInsets.only(
              top: context.mediaQueryPadding.top, left: 20.w, right: 20.w),
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon(R.ASSETS_IMAGES_BACK_SVG, () => Get.back()),
              icon(R.ASSETS_IMAGES_MORE_SVG, () {})
            ],
          ),
        ),
        Divider(
          height: 1.h,
          thickness: 1.h,
        ),
      ],
    );
  }

  Widget _webView() => Obx(() {
        return InAppWebView(
          key: controller.webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(controller.url.value)),
          onLoadStart: (_, Uri? url) {
            Log.i('WebView onLoadStart: $url');
          },
          onLoadStop: (controller, url) {
            Log.i('WebView onLoadStop: $url');

            controller.getTitle().then((value) {
              Log.wtf(value);
            });
          },
          onProgressChanged: (_, int progress) {
            controller.progress.value = progress.toDouble();
          },
          onWebViewCreated: (InAppWebViewController c) {
            controller.setInAppWebViewController = c;
          },
        );
      });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async {
          if (await controller.getInAppWebViewController.canGoBack() == true) {
            controller.getInAppWebViewController.goBack();
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: Column(
            children: <Widget>[
              _appBar(context),
              Expanded(child: _webView()),
            ],
          ),
        ),
      ),
    );
  }
}



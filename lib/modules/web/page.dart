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
        Obx(() {
          return Container(
            color: context.canvasColor,
            padding: EdgeInsets.only(
                top: context.mediaQueryPadding.top, left: 20.w, right: 20.w),
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon(R.ASSETS_IMAGES_BACK_SVG, () => Get.back()),
                controller.loadState.value == LoadState.LOADING
                    ? SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text(
                        controller.title.value,
                      ),
                icon(R.ASSETS_IMAGES_MORE_SVG, () {})
              ],
            ),
          );
        }),
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
            controller.loadState.value = LoadState.LOADING;
          },
          onLoadStop: (webController, url) {
            Log.i('WebView onLoadStop: $url');
            webController.getTitle().then((value) {
              controller.loadState.value = LoadState.SUCCESS;
              controller.title.value = value!;
            });
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

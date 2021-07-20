import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/app_bar_icon.dart';
import 'controller.dart';

class WebPage extends StatelessWidget {
  final controller = Get.find<WebController>();

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
    return WillPopScope(
      onWillPop: () async {
        if (await controller.getInAppWebViewController.canGoBack() == true) {
          controller.getInAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: context.canvasColor,
          leading: Container(
            padding: EdgeInsets.all(12.r),
            child: AppBarIcon(
              assetName: R.ASSETS_IMAGES_BACK_SVG,
              onTap: () => Get.back(),
            ),
          ),
          centerTitle: true,
          title: Obx(() {
            return controller.loadState.value == LoadState.LOADING
                ? SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : appBarText(
                    controller.title.value,
                  );
          }),
          actions: [
            Container(
              padding: EdgeInsets.all(12.r),
              child:
                  AppBarIcon(assetName: R.ASSETS_IMAGES_MORE_SVG, onTap: () {}),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            // _appBar(context),
            Expanded(child: _webView()),
          ],
        ),
      ),
    );
  }
}

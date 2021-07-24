import 'package:flutter/cupertino.dart';
import 'package:wan_android_getx/const/constants.dart';


class EllipseTabIndicator extends Decoration {

  EllipseTabIndicator();

  @override
  _EllipsePainter createBoxPainter([VoidCallback? onChanged]) {
    return new _EllipsePainter(this, onChanged);
  }
}

class _EllipsePainter extends BoxPainter {
  final EllipseTabIndicator decoration;

  _EllipsePainter(this.decoration, VoidCallback? onChanged,)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    assert(cfg.size != null);
    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = Offset(offset.dx-5.w, offset.dy+5.h) & Size(cfg.size!.width+10, cfg.size!.height/1.5);
    final Paint paint = Paint();
    paint.color = Get.theme.primaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(12.0)), paint);
  }
}

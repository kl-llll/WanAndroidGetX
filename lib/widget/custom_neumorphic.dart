import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomNeumorphic extends StatelessWidget {
  const CustomNeumorphic(
      {required this.child, required this.boxShape, Key? key})
      : super(key: key);

  final Widget child;
  final NeumorphicBoxShape boxShape;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: boxShape,
          depth: 2,
          lightSource: LightSource.topLeft,
          color: Colors.transparent),
      child: child,
    );
  }
}

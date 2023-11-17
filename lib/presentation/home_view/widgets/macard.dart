import 'package:flutter/material.dart';

class MACard extends StatelessWidget {
  final double borderRadius;
  final double borderWidth;
  final double shadowIntensity;
  final Widget child;
  final Color color;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  const MACard({
    required this.child,
    double? borderRadius,
    double? borderWidth,
    double? shadowIntensity,
    Color? color,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    this.margin,
    super.key,
  })  : borderRadius = borderRadius ?? 20.0,
        borderWidth = borderWidth ?? 2.0,
        shadowIntensity = shadowIntensity ?? 4,
        color = color ?? const Color.fromARGB(90, 224, 224, 224),
        borderColor = borderColor ?? const Color(0xFF000000),
        padding = padding ?? const EdgeInsets.all(12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth),
        boxShadow: [
          BoxShadow(
            offset: Offset(shadowIntensity / 2, shadowIntensity / 2),
            blurRadius: shadowIntensity,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.circular(borderRadius),
        // color: color,
      ),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

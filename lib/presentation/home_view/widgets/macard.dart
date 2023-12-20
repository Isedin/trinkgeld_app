import 'package:flutter/material.dart';

/// Die Klasse MACard repräsentiert ein benutzerdefiniertes Flutter-Widget für eine stilisierte Karte.
class MACard extends StatelessWidget {
  /// Der Radius der abgerundeten Ecken der Karte.
  final double borderRadius;

  /// Die Breite des Kartenrahmens.
  final double borderWidth;

  /// Die Intensität des Schattens auf der Karte.
  final double shadowIntensity;

  /// Das Widget, das innerhalb der Karte angezeigt wird.
  final Widget child;

  /// Die Hintergrundfarbe der Karte.
  final Color color;

  /// Die Rahmenfarbe der Karte.
  final Color borderColor;

  /// Der Innenabstand der Karte.
  final EdgeInsetsGeometry padding;

  /// Der Außenabstand der Karte (optional).
  final EdgeInsetsGeometry? margin;

  /// Konstruktor für die Initialisierung von Instanzvariablen mit Standardwerten.
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
  Widget build(BuildContext context) => Container(
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

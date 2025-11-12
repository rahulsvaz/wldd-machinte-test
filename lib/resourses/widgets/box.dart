import 'package:flutter/material.dart';

import '../styles/colors_class.dart';
import 'click.dart';


class Box extends StatelessWidget {
  final BoxShape? shape;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final Border? customBorder; // New property for fully customizable borders

  const Box({
    super.key,
    this.boxShadow,
    this.margin,
    this.gradient,
    this.child,
    this.color,
    this.onTap,
    this.borderRadius,
    this.borderColor,
    this.height,
    this.width,
    this.borderWidth,
    this.shape,
    this.padding,
    this.customBorder, // Accept custom border
  });

  @override
  Widget build(BuildContext context) {
    return (onTap != null)?  Click(
      onPressed: onTap!,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(

          gradient: gradient,
          boxShadow: boxShadow,
          shape: shape ?? BoxShape.rectangle,
          color: color,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius ?? 1), // No radius if circle
          border: customBorder ??
              Border.all(
                color: borderColor ?? Palette.transparent,
                width: borderWidth ?? 1,
              ), // Use customBorder if provided
        ),
        child: child,
      ),
    ) :  Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: boxShadow,
        shape: shape ?? BoxShape.rectangle,
        color: color,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(borderRadius ?? 1), // No radius if circle
        border: customBorder ??
            Border.all(
              color: borderColor ?? Palette.transparent,
              width: borderWidth ?? 1,
            ), // Use customBorder if provided
      ),
      child: child,
    );
  }
}

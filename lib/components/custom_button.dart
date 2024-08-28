import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  Size minimumSize;
  String? text;
  double fontSize, borderRadius;
  Color? textColor;
  TextStyle? customTextStyle;
  bool isLoading;
  Widget? child;
  Widget? prefix;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.foregroundColor,
      this.text,
      this.minimumSize = const Size(140, 60),
      this.fontSize = 20,
      this.borderRadius = 16,
      this.textColor,
      this.isLoading = false,
      this.customTextStyle,
      this.child,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          minimumSize: minimumSize,
        ),
        child: isLoading
            ? LoadingAnimationWidget.fourRotatingDots(
                color: foregroundColor,
                size: 30,
              )
            : prefix != null
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    prefix!,
                    const SizedBox(width: 5),
                    Text(
                      text!,
                      style: customTextStyle ??
                          TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize),
                    )
                  ])
                : child ??
                    Text(
                      text!,
                      style: customTextStyle ??
                          TextStyle(
                              color: foregroundColor,
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize),
                    ));
  }
}

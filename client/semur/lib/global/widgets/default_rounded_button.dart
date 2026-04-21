import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultRoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color color, textColor;
  final double borderRadius;
  final int maxLines;
  final double padding;
  final TextStyle? textStyle;
  final double minHeight;

  const DefaultRoundedButton({
    super.key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
    this.borderRadius = 29,
    this.maxLines = 1,
    this.padding = 10,
    this.textStyle,
    this.minHeight = 45,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: press,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          shape: BoxShape.rectangle,
        ),
        child: Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: textStyle ??
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    // fontSize: 24,
                  ),
        ),
      ),
    );
  }
}

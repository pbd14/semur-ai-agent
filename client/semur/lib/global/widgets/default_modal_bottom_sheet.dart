import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';

class DefaultModalBottomSheet {
  final BuildContext context;
  Color? backgroundColor;
  final bool isScrollControlled;
  final bool enableDrag;
  final bool isDismissible;
  final double maxWidth;
  final bool canPop;
  final bool expand;
  final double maxChildSize;
  final double initialChildSize;

  DefaultModalBottomSheet({
    required this.context,
    this.backgroundColor,
    this.isScrollControlled = true,
    this.enableDrag = true,
    this.isDismissible = true,
    this.maxWidth = 800,
    this.canPop = true,
    this.expand = false,
    this.maxChildSize = 1,
    this.initialChildSize = 0.8,
  }) {
    backgroundColor ??= AppColors.lightPrimaryColor;
  }

  Future show(Widget child) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop,
          child: DraggableScrollableSheet(
            expand: expand,
            maxChildSize: maxChildSize,
            initialChildSize: initialChildSize,
            builder: (_, controller) {
              return child;
            },
          ),
        );
      },
    );
  }
}

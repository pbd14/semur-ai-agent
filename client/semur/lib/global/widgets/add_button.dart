import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semur/helpers/platform/platform_info.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onPressed;
  final bool isMaxWidthLimited;

  const AddButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.isMaxWidthLimited = true,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if ((!kIsWeb && (PlatformInfo.isAndroid || PlatformInfo.isIOS)) ||
        size.width <= 480) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: isMaxWidthLimited ? 150 : size.width,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color, width: 1.0),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.plus, size: 20, color: color),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: isMaxWidthLimited ? 150 : size.width,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: color, width: 1.0),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.plus, size: 20, color: color),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

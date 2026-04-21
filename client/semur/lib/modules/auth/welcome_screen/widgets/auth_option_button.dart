import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthOptionButton extends StatelessWidget {
  const AuthOptionButton({
    super.key,
    required Function() onPressed,
    required Widget iconWidget,
    required String text,
    required Color color,
    required Color textColor,
  })  : _onPressed = onPressed,
        _iconWidget = iconWidget,
        _text = text,
        _color = color,
        _textColor = textColor;

  final Function() _onPressed;
  final Widget _iconWidget;
  final String _text;
  final Color _color;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _onPressed,
      child: Container(
          // width: pw == 0 ? size.width * width : pw,
          constraints: BoxConstraints(minHeight: 45),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(25),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconWidget,
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  _text,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: _textColor,
                        fontWeight: FontWeight.w700,
                        // fontSize: 24,
                      ),
                ),
              ),
            ],
          )),
    );
  }
}

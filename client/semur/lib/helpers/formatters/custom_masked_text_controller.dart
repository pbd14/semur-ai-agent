import 'package:flutter/material.dart';

class CustomMaskedTextController extends TextEditingController {
  CustomMaskedTextController({
    super.text,
    this.mask,
    Map<String, RegExp>? translator,
  }) {
    this.translator =
        translator ?? CustomMaskedTextController.getDefaultTranslator();

    addListener(() {
      var previous = _lastUpdatedText;
      if (beforeChange(previous, text)) {
        updateText(text);
        afterChange(previous, text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(text);
  }

  String? mask;

  Map<String, RegExp>? translator;

  void afterChange(String previous, String next) {}

  bool beforeChange(String previous, String next) {
    return true;
  }

  String _lastUpdatedText = '';

  void updateText(String? text) {
    if (text != null) {
      this.text = _applyMask(mask!, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: (text).length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*'),
      '9': RegExp(r'[?0-9]'),
    };
  }

  String _applyMask(String mask, String value) {
    var result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    var maskEnabled = false;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      if (maskChar == '[') {
        maskEnabled = true;
        //valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      if (maskChar == ']') {
        maskEnabled = false;
        //valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (maskEnabled && translator!.containsKey(maskChar)) {
        if (translator![maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

class CustomMaskedTextControllerAlpha extends TextEditingController {
  CustomMaskedTextControllerAlpha({
    String? text,
    this.mask,
  }) : super(text: text) {
    translator =
        translator ?? CustomMaskedTextControllerAlpha.getDefaultTranslator();

    if (text!.isNotEmpty) {
      value = value.copyWith(
        text: _applyMask(mask!, text),
        selection: TextSelection.fromPosition(
            TextPosition(offset: text.isNotEmpty ? text.length : -1)),
        composing: TextRange.empty,
      );
    }

    addListener(() {
      final masked = _applyMask(mask!, this.text);
      if (this.text != masked) {
        value = value.copyWith(
          text: masked,
          //selection: TextSelection.collapsed(offset: masked.isNotEmpty ? masked.length : -1),
          selection: TextSelection.fromPosition(
              TextPosition(offset: masked.isNotEmpty ? masked.length : -1)),
          composing: TextRange.empty,
        );
      }
    });
  }

  String? mask;
  Map<String, RegExp>? translator;

  void updateText(String text) {}

  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*'),
      '9': RegExp(r'[?0-9]'),
    };
  }

  String _applyMask(String mask, String value) {
    var result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator!.containsKey(maskChar)) {
        if (translator![maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

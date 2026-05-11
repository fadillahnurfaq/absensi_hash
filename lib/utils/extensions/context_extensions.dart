import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension HideKeyboardExt on BuildContext {
  void hideKeyboard() {
    if (!kIsWeb) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    FocusScope.of(this).unfocus();
  }
}


extension DimensionExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get topPadding => MediaQuery.of(this).padding.top;

  double get bottomPadding => MediaQuery.of(this).padding.bottom;
}
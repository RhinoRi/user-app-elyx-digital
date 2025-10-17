import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
}

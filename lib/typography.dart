import 'dart:io';
import 'dart:ui';

class FontWeightOptimizedForOperatingSystem {
  static final FontWeight thin = Platform.isMacOS ? FontWeight.w200 : FontWeight.w300;
  static final FontWeight normal = Platform.isMacOS ? FontWeight.w300 : FontWeight.w400;
  static final FontWeight semibold = Platform.isMacOS ? FontWeight.w400 : FontWeight.w500;
  static final FontWeight bold = Platform.isMacOS ? FontWeight.w500 : FontWeight.w600;
}

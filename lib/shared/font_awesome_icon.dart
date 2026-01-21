import 'package:flutter/material.dart';

class FontAwesomeIcons {
  FontAwesomeIcons._();

  static IconData icon(int character) {
    return IconData(character, fontFamily: "FontAwesome Light");
  }

  // Window controls
  static final IconData minimize = icon(0xf068);
  static final IconData maximize = icon(0xf2d0);
  static final IconData close = icon(0xf00d);

  // Navigation arrows
  static final IconData arrowUp = icon(0xf062);
  static final IconData arrowDown = icon(0xf063);
  static final IconData chevronUp = icon(0xf077);
  static final IconData chevronDown = icon(0xf078);

  // Panels
  static final IconData sidebarLeft = icon(0xf06e);
  static final IconData sidebarRight = icon(0xf070);

  // General icons
  static final IconData speed = icon(0xf3fd);
  static final IconData book = icon(0xf02d);
  static final IconData feedback = icon(0xf4aa);
  static final IconData sync = icon(0xf021);
  static final IconData fileSlash = icon(0xf573);
  static final IconData certificate = icon(0xf5ea);
  static final IconData cloudArrowUp = icon(0xf0ee);
  static final IconData terminal = icon(0xf120);
  static final IconData desktop = icon(0xf108);
  static final IconData sun = icon(0xf185);
  static final IconData moon = icon(0xf186);
  static final IconData rocket = icon(0xf135);
  static final IconData gear = icon(0xf013);
}

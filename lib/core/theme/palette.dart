import 'dart:math';

import 'package:flutter/painting.dart';

class Palette {
  static const Color background = Color(0xff232946);
  static const Color accent = Color(0xffeebbc3);
  static const Color headline = Color(0xfffffffe);
  static const Color paragraph = Color(0xffb8c1ec);
}

class PurpleShades {
  static const List<Color> colors = [
    Color(0xFF9F2B68),
    Color(0xFFBF40BF),
    Color(0xFF800020),
    Color(0xFF702963),
    Color(0xFFAA336A),
    Color(0xFF301934),
    Color(0xFF483248),
    Color(0xFF5D3FD3),
    Color(0xFFE6E6FA),
    Color(0xFFCBC3E3),
    Color(0xFFCF9FFF),
    Color(0xFFAA98A9),
    Color(0xFFE0B0FF),
    Color(0xFF915F6D),
    Color(0xFF770737),
    Color(0xFFDA70D6),
    Color(0xFFC3B1E1),
    Color(0xFFCCCCFF),
    Color(0xFF673147),
    Color(0xFFA95C68),
    Color(0xFF800080),
    Color(0xFF51414F),
    Color(0xFF953553),
    Color(0xFFD8BFD8),
    Color(0xFF630330),
    Color(0xFF7F00FF),
    Color(0xFF722F37),
    Color(0xFFBDB5D5),
  ];

  static Color get randomColor => colors[Random().nextInt(colors.length)];
}

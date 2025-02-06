import 'package:flutter/material.dart';

enum PlatescapeColors {
  green("Green", Colors.green),
  blue("Blue", Colors.blue),
  purple("Purple", Colors.purple),
  yellow("Yellow", Colors.yellow);

  final String name;
  final Color color;

  const PlatescapeColors(this.name, this.color);
}

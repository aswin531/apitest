import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final TextStyle heading = GoogleFonts.openSans(
      fontSize: 22, fontWeight: FontWeight.w500, color: Colors.grey);

  static const TextStyle subheading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle search = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandTextStyles {
  static final unselectedButton = GoogleFonts.asap(
    textStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  );
  static final selectedButton = GoogleFonts.asap(
    textStyle: const TextStyle(
      //color: Color(0xFFE09090),
      color: Color.fromARGB(0xFF, 196, 119, 118),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  );
}

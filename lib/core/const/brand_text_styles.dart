import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';

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
      color: BrandColors.inspirationBackGroundDarker,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  );
}

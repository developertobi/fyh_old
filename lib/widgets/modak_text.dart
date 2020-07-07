import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModakText extends StatelessWidget {
  final String text;
  final double fontSize;

  const ModakText({@required this.text, @required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.modak(
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}

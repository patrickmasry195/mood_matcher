import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 15,
          backgroundColor: kMainColor,
          minimumSize: const Size(400, 60),
          maximumSize: const Size(400, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.lexend(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}

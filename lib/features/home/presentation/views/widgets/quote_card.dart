import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 237,
      width: 323,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff812929),
            Color(0xff1D1A1A),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              "❝ Sometimes the best way to help yourself is to help someone else ❞",
              style: GoogleFonts.lexend(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Iroh",
              style: GoogleFonts.lexend(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            "From: Avatar the Last Airbender",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

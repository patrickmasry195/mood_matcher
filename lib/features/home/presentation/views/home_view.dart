import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/categories_slider.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/quote_card.dart';
import 'widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = "HomePage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.homeBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const CustomAppbar(),
              const SizedBox(
                height: 30,
              ),
              const QuoteCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 30, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose from our categories :",
                    style: GoogleFonts.lexend(
                      color: kMainColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CategoriesSlider(),
            ],
          ),
        ),
      ],
    );
  }
}

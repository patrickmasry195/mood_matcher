import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/home/presentation/view_models/cubit/quote_cubit.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({super.key});

  static String id = "QuotePage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.quoteBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<QuoteCubit, QuoteState>(
            builder: (context, state) {
              if (state is QuoteLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (state is QuoteLoaded) {
                return SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 70, 5, 0),
                          child: AutoSizeText(
                            "❝ ${state.quote.quote} ❞",
                            style: GoogleFonts.shadowsIntoLight(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        AutoSizeText(
                          state.quote.author,
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AutoSizeText(
                          'from: ${state.quote.source}',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is QuoteError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/features/home/presentation/view_models/cubit/quote_cubit.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteCubit()..loadQuotes(),
      child: Container(
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
        child: BlocBuilder<QuoteCubit, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text(
                      "❝ ${state.quote.quote} ❞",
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child: Text(
                      state.quote.author,
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "From: ${state.quote.source}",
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
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
    );
  }
}

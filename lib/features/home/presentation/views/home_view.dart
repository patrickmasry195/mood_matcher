import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/home/presentation/views/quote_view.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/categories_slider.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/quote_card.dart';
import '../view_models/cubit/quote_cubit.dart';
import 'widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = "HomePage";

  Future<void> _refreshPage(BuildContext context) {
    context.read<QuoteCubit>().loadQuotes();
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.homeBackground,
        RefreshIndicator(
          onRefresh: () => _refreshPage(context),
          color: Colors.red,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const CustomAppbar(),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<QuoteCubit, QuoteState>(
                    builder: (context, state) {
                      if (state is QuoteLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else if (state is QuoteLoaded) {
                        return QuoteCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: context.read<QuoteCubit>(),
                                  child: const QuotePage(),
                                ),
                              ),
                            );
                          },
                          quote: state.quote.quote,
                        );
                      } else if (state is QuoteError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
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
          ),
        ),
      ],
    );
  }
}

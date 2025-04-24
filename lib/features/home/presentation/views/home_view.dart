import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/home/presentation/view_models/quote_cubit/quote_cubit.dart';
import 'package:mood_matcher/features/home/presentation/view_models/user_cubit/user_cubit.dart';
import 'package:mood_matcher/features/home/presentation/views/quote_view.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/categories_slider.dart';
import 'package:mood_matcher/features/home/presentation/views/widgets/quote_card.dart';
import 'widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = "HomePage";

  Future<void> _refreshPage(BuildContext context) {
    context.read<QuoteCubit>().loadQuotes();
    context.read<UserCubit>().loadUserProfile();
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const CircularProgressIndicator(
                          color: kMainColor,
                        );
                      } else if (state is UserLoaded) {
                        return CustomAppBar(
                          userName: state.name,
                          userAvatarUrl: state.avatarUrl,
                        );
                      } else if (state is UserError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
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

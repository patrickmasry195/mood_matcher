import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mood_matcher/core/utils/assets.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/chatbot_view.dart';
import 'category.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Category(
          imagePath: AssetsData.movieCategory,
          categoryName: "Movies",
          onTap: () {
            Navigator.pushNamed(context, ChatBotPage.id);
          },
        ),
        Category(
          imagePath: AssetsData.tvShowsCategory,
          categoryName: "Tv Shows",
          onTap: () {},
        ),
        Category(
          imagePath: AssetsData.animeCategory,
          categoryName: "Anime",
          onTap: () {},
        ),
        Category(
          imagePath: AssetsData.musicCategory,
          categoryName: "Music",
          onTap: () {},
        ),
        Category(
          imagePath: AssetsData.gamesCategory,
          categoryName: "Games",
          onTap: () {},
        ),
        Category(
          imagePath: AssetsData.booksCategory,
          categoryName: "Books",
          onTap: () {},
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 3,
        initialPage: 0,
        viewportFraction: 0.4,
        enableInfiniteScroll: false,
        padEnds: false,
      ),
    );
  }
}

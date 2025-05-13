import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/register_cubit/register_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/views/authentication_view.dart';
import 'package:mood_matcher/features/authentication/services/supabase_auth_service.dart';
import 'package:mood_matcher/features/avatar/presentation/views/avatar_view.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/books_chatbot_cubit/books_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/games_chatbot_cubit/games_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/movie_chatbot_cubit/movie_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/music_chatbot_cubit/music_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/movies_chatbot_view.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/tvshows_chatbot_view.dart';
import 'package:mood_matcher/features/chatbot/services/anime_chatbot_service.dart';
import 'package:mood_matcher/features/chatbot/services/books_chatbot_service.dart';
import 'package:mood_matcher/features/chatbot/services/games_chatbot_service.dart';
import 'package:mood_matcher/features/chatbot/services/movie_chatbot_service.dart';
import 'package:mood_matcher/features/chatbot/services/music_chatbot_service.dart';
import 'package:mood_matcher/features/home/presentation/view_models/user_cubit/user_cubit.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/login_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/features/userprofile/presentation/views/userprofile_view.dart';
import 'core/utils/supabase_config.dart';
import 'features/chatbot/presentation/view_models/anime_chatbot_cubit/anime_chatbot_cubit.dart';
import 'features/chatbot/presentation/view_models/series_chatbot_cubit/series_chatbot_cubit.dart';
import 'features/chatbot/presentation/views/anime_chatbot_view.dart';
import 'features/chatbot/presentation/views/books_chatbot_view.dart';
import 'features/chatbot/presentation/views/games_chatbot_view.dart';
import 'features/chatbot/presentation/views/music_chatbot_view.dart';
import 'features/chatbot/services/series_chatbot_service.dart';
import 'features/home/presentation/view_models/quote_cubit/quote_cubit.dart';
import 'features/home/presentation/views/quote_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: kSupabaseURL,
    anonKey: kSupabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuoteCubit>(
          create: (context) => QuoteCubit()..loadQuotes(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(SupabaseAuthService()),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(SupabaseAuthService()),
        ),
        BlocProvider<UserCubit>(
          create: (context) =>
              UserCubit(SupabaseAuthService())..loadUserProfile(),
        ),
        BlocProvider<MusicChatbotCubit>(
          create: (context) => MusicChatbotCubit(MusicChatbotService()),
        ),
        BlocProvider<MovieChatbotCubit>(
          create: (context) => MovieChatbotCubit(MovieChatbotService()),
        ),
        BlocProvider<TvShowsChatbotCubit>(
          create: (context) => TvShowsChatbotCubit(SeriesChatbotService()),
        ),
        BlocProvider<AnimeChatbotCubit>(
          create: (context) => AnimeChatbotCubit(AnimeChatbotService()),
        ),
        BlocProvider<GameChatbotCubit>(
          create: (context) => GameChatbotCubit(GameChatbotService()),
        ),
        BlocProvider<BookChatbotCubit>(
          create: (context) => BookChatbotCubit(BookChatbotService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Supabase.instance.client.auth.currentSession != null
              ? Future.value(true)
              : Future.value(false),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(
                color: kMainColor,
              );
            }

            return snapshot.data == true
                ? const HomePage()
                : const AuthenticationPage();
          },
        ),
        routes: {
          AuthenticationPage.id: (context) => const AuthenticationPage(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          AvatarPage.id: (context) => const AvatarPage(),
          HomePage.id: (context) => const HomePage(),
          MoviesChatBotPage.id: (context) => const MoviesChatBotPage(),
          TvShowsChatBotPage.id: (context) => const TvShowsChatBotPage(),
          MusicChatBotPage.id: (context) => const MusicChatBotPage(),
          GamesChatBotPage.id: (context) => const GamesChatBotPage(),
          BooksChatBotPage.id: (context) => const BooksChatBotPage(),
          AnimeChatBotPage.id: (context) => const AnimeChatBotPage(),
          UserProfilePage.id: (context) => const UserProfilePage(),
          QuotePage.id: (context) => const QuotePage(),
        },
      ),
    );
  }
}

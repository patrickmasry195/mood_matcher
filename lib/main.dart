import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/register_cubit/register_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/views/authentication_view.dart';
import 'package:mood_matcher/features/authentication/services/supabase_auth_service.dart';
import 'package:mood_matcher/features/avatar/presentation/views/avatar_view.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:mood_matcher/features/home/presentation/view_models/cubit/quote_cubit.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/login_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/features/userprofile/presentation/views/userprofile_view.dart';
import 'core/utils/supabase_config.dart';
import 'features/home/presentation/views/quote_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: kSupabaseURL,
    anonKey: kSupabaseAnonKey,
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AuthenticationPage.id,
        routes: {
          AuthenticationPage.id: (context) => const AuthenticationPage(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          AvatarPage.id: (context) => const AvatarPage(),
          HomePage.id: (context) => const HomePage(),
          ChatBotPage.id: (context) => const ChatBotPage(),
          UserProfilePage.id: (context) => const UserProfilePage(),
          QuotePage.id: (context) => const QuotePage(),
        },
      ),
    );
  }
}

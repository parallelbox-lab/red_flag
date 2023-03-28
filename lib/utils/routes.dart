
import 'package:flutter/material.dart';
import 'package:red_flag/screens/affirmations/affirmations.dart';
import 'package:red_flag/screens/auth/login/login.dart';
import 'package:red_flag/screens/auth/profile_password/profile_password.dart';
import 'package:red_flag/screens/auth/register/intro_register.dart';
import 'package:red_flag/screens/auth/register/register.dart';
import 'package:red_flag/screens/auth/reset_password/reset_password.dart';
import 'package:red_flag/screens/auth/verification/verification.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/screens/chats/widgets/chat_screen.dart';
import 'package:red_flag/screens/music_videos/music_videos.dart';
import 'package:red_flag/screens/notificattion/notification.dart';
import 'package:red_flag/screens/onboarding/onboarding.dart';
import 'package:red_flag/screens/payments_subscription/payment_sub.dart';
import 'package:red_flag/screens/profile/profile.dart';
import 'package:red_flag/screens/questionaire/widgets/questionaire_start.dart';
import 'package:red_flag/screens/riddles/riddles.dart';
import 'package:red_flag/screens/splash/splash.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => const Splash(),
  Onboarding.routeName: (context) => const Onboarding(),
  IntroRegister.routeName: (context) => const IntroRegister(),
  Register.routeName: (context) => const Register(),
  ResetPassword.routeName: (context) => const ResetPassword(),
  Verification.routeName: (context) => const Verification(),
  ProfilePassword.routeName: (context) => const ProfilePassword(),
  Login.routeName: (context) => const Login(),
  BottomNavigation.routeName: (context) => const BottomNavigation(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  QuestionaireStart.routeName: (context)=> const QuestionaireStart(),
  Profile.routeName:(context) => const Profile(),
  Notifications.routeName: (context)=> const Notifications(),
  Riddles.routeName: (context)=> const Riddles(),
  MusicVideo.routeName: (context) => const MusicVideo(),
  Affirmations.routeName: (context) => const Affirmations(),
  PaymentSubscription.routeName: (context) => const PaymentSubscription()
};
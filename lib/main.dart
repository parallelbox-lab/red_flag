
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:red_flag/data/repository/base_auth.dart';
import 'package:red_flag/data/services/apple_signin_checker.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/screens/bottom_navigation.dart';
import 'package:red_flag/screens/onboarding/onboarding.dart';
import 'package:red_flag/screens/splash/splash.dart';
import 'package:red_flag/utils/routes.dart';
import 'package:red_flag/view_model/admin_get_users_view_model.dart';
import 'package:red_flag/view_model/admin_post.dart';
import 'package:red_flag/view_model/affirmation_view_model.dart';
import 'package:red_flag/view_model/login_view_model.dart';
import 'package:red_flag/view_model/our_stories_view_model.dart';
import 'package:red_flag/view_model/pay_pal_init_view_model.dart';
import 'package:red_flag/view_model/questionaire_view_model.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/view_model/chat_view_model.dart';
import 'package:red_flag/view_model/music_view_model.dart';
import 'package:red_flag/view_model/post_view_model.dart';
import 'package:red_flag/view_model/reset_password_view_model.dart';
import 'package:red_flag/view_model/riddle_view_model.dart';
import 'package:red_flag/view_model/share_post_view_model.dart';
import 'package:red_flag/view_model/subscription_view_model.dart';
import 'package:red_flag/view_model/theme_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

final _configuration = Platform.isAndroid ? PurchasesConfiguration('goog_aatnuRQPdexxkhjYFuFnWMclyCf') :  PurchasesConfiguration("appl_gTLHvpVpKZHYvHEeqpTkfHrcfps");

//receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.configure(_configuration 
  ..appUserID =  UserData.getUserId()
);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Auth.init();
  await UserData.init();
  await Firebase.initializeApp(
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    badge: true,
  );
 final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child:const MyApp(),
  ));}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    Purchases.addCustomerInfoUpdateListener((_) => updateCustomerStatus());
  }
 
  Future updateCustomerStatus() async {
  final up = SubscriptionViewModel();
  final customerInfo = await Purchases.getCustomerInfo();
  final ent =  customerInfo.entitlements.active['all_features'];
  bool _sub  = ent != null;
  if(UserData.getUserId() != null){
  // await FirebaseFirestore.instance.collection("UserData").doc(UserData.getUserId()).update({"isPremium":_sub });
  await up.updateSubscriptionStatus(status:_sub);
  }

  }
  @override
  Widget build(BuildContext context) {
  return Sizer(builder: (context, orientation, deviceType) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => PostViewModel()),
      ChangeNotifierProvider(create: (_) => MusicViewModel()),
      ChangeNotifierProvider(create: (_) => RiddleViewModel()),
      ChangeNotifierProvider(create: (_) => AffirmationViewModel()),
      ChangeNotifierProvider(create: (_) => SharePostViewModel()),
      ChangeNotifierProvider(create: (_) => ChatViewModel()),
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => OurStoriesViewModel()),
      ChangeNotifierProvider(create: (_) => AdminPost()),
      ChangeNotifierProvider(create: (_) => QuestionaireViewModel()),
      ChangeNotifierProvider(create: (_) => AdminGetUsersViewModel()),
      ChangeNotifierProvider(create: (_) => ResetPasswordViewModel()),
      ChangeNotifierProvider(create: (_) => PayPalInitViewModel()),
      ChangeNotifierProvider(create: (_) => SubscriptionViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeManager(ThemeData.light())),
    ],
      child:const MaterialAppwithTTheme(),
    );
  });
  }
}

class MaterialAppwithTTheme extends StatelessWidget {
  const MaterialAppwithTTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeManager _themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Flag',
      theme: _themeManager.getTheme(),
      home: UpgradeAlert(
        upgrader: Upgrader(dialogStyle:Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material),
        child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    // print(snapshot.data);
                    if (snapshot.hasData) {
                      return const Splash(nextScreen:BottomNavigation() );
                    } else {
                      return const Splash(nextScreen: Onboarding());
                    }
                  }),
      ),
         // initialRoute: Splash.routeName,
          routes: routes);
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_flutter/providers/user_provider.dart';
import 'package:insta_flutter/responsive/mobile_screen_layout.dart';
import 'package:insta_flutter/responsive/responsive_layout_screen.dart';
import 'package:insta_flutter/responsive/web_screen_layout.dart';
import 'package:insta_flutter/screens/login_screen.dart';
import 'package:insta_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBo53wrSHicYAQOUSrpgcO6JFapVqsAiQw",
        appId: "1:563182574239:web:55a3cacd579df5dd2be0aa",
        messagingSenderId: "563182574239",
        projectId: "alum-connect-70dd8",
        storageBucket: "alum-connect-70dd8.appspot.com",
      ),
    );
  } else {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ' Alum Connect',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

//export PATH="$PATH:/Users/prikshit/Desktop/flutter/bin"
//cmd + shift + P : To open Pubspec Assist
//parth - 123456
//prikshit - prikshit.cs20@rvce.edu.in -123456
//? means nullable
// _ means private
// ! means not null
// flutter run -d chrome --web-renderer html
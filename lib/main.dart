import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/core/utils/route_utils.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:chat_app/ui/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBX-kTXkeulFhvUyNE8TfpAyUGwmmopA94",
        authDomain: "meiari-b79a2.firebaseapp.com",
        projectId: "meiari-b79a2",
        storageBucket: "meiari-b79a2.appspot.com", // Fix incorrect URL
        messagingSenderId: "387615213829",
        appId: "1:387615213829:web:d22cae1c00ca3d8714cf6c",
        measurementId: "G-Y3MD26Q7N0",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => UserProvider(DatabaseService()),
        child: const MaterialApp(
          onGenerateRoute: RouteUtils.onGenerateRoute,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

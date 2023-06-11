import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/utils/error_page.dart';
import 'package:komikzone/app/utils/loading_page.dart';
import 'package:komikzone/app/utils/splash_screen.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return FutureBuilder(
            future: Future.delayed(
              Duration(seconds: 3),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "KomikZone", initialRoute: Routes.LOGIN,
                  // initialRoute:
                  //     snapshot.data != null && snapshot.data!.emailVerified == true
                  //         ? Routes.DASHBOARD
                  //         : Routes.LOGIN,
                  getPages: AppPages.routes,
                );
              }
              return SplashScreen();
            },
          );
        }
        return LoadingPage();
      },
    );

    // return GetMaterialApp(
    //   title: "Application",
    //   initialRoute: Routes.LOGIN,
    //   getPages: AppPages.routes,
    // );
  }
}

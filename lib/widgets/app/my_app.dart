import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';


class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie DB',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.mainDarkBlue,
        ),
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', ''),
      ],
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.loaderWidget,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}

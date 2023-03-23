import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import 'Layout/NewsLayout.dart';
import 'cubit/cubit.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: "isDark");

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..changeDarkTheme(fromShared: isDark)
        ..getBusinessArticles()
        ..getSportsArticles()
        ..getScienceArticles(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                elevation: 40,
              ),
              //GoogleFonts.lobsterTextTheme(Theme.of(context).textTheme)
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,
              )),
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.green,
              appBarTheme: AppBarTheme(
                  color: Colors.black,
                  elevation: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.white,
                elevation: 40,
              ),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              )),
              scaffoldBackgroundColor: Colors.black12,
            ),
            themeMode: NewsCubit.get(context).isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            //NewsCubit().isDarkTheme
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}

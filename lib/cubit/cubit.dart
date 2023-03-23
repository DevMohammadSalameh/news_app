import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/models/science/ScienceScreen.dart';

import '../models/business/BusinessScreen.dart';
import '../models/sports/SportsScreen.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool isDarkTheme = true;

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Science",
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: "Settings",
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  void changeDarkTheme({bool? fromShared}) {
    if (fromShared == null) {
      isDarkTheme = !isDarkTheme;
      CacheHelper.setData(key: "isDark", value: isDarkTheme);
      emit(NewsChangeThemeState());
    } else {
      isDarkTheme = fromShared;
      emit(NewsChangeThemeState());
    }
  }

  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];

  void getBusinessArticles() {
    emit(NewsLoadingBusinessState());
    DioHelper.getDate(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "0d5239bc515843bcb57635a8961cd72d",
    }).then((value) {
      //print(value.data.toString());
      businessArticles = value.data["articles"];
      // print(businessArticles[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  void getSportsArticles() {
    emit(NewsLoadingSportsState());
    DioHelper.getDate(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "sports",
      "apiKey": "0d5239bc515843bcb57635a8961cd72d",
    }).then((value) {
      //print(value.data.toString());
      sportsArticles = value.data["articles"];
      // print(sportsArticles[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error));
    });
  }

  void getScienceArticles() {
    emit(NewsLoadingScienceState());
    DioHelper.getDate(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "science",
      "apiKey": "0d5239bc515843bcb57635a8961cd72d",
    }).then((value) {
      //print(value.data.toString());
      scienceArticles = value.data["articles"];
      // print(scienceArticles[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error));
    });
  }
}

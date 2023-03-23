abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsChangeThemeState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsSettingsState extends NewsStates {}

//Business
class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsLoadingBusinessState extends NewsStates {}

//Sports
class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsLoadingSportsState extends NewsStates {}

//Science
class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsLoadingScienceState extends NewsStates {}

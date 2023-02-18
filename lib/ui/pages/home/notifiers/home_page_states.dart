abstract class HomePageState {}

class InitialHomePageState extends HomePageState {}

class NoAccountHomePageState extends HomePageState {}

class LoadingHomePageState extends HomePageState {}

class LoadedHomePageState extends HomePageState {}

class AccountAddedHomePageState extends HomePageState {}

class ErrorHomePageState extends HomePageState {
  final String error;

  ErrorHomePageState(this.error);
}

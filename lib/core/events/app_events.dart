abstract class AppEvent {}

class UserLoggedIn extends AppEvent {
  final String userId;
  UserLoggedIn(this.userId);
}

class UserLoggedOut extends AppEvent {}

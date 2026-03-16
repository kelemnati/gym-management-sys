class SessionManager {
  String? _token;
  bool _isLoggedIn = false;

  void setToken(String token) {
    _token = token;
  }

  String? getToken() => _token;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  bool isLoggedIn() => _isLoggedIn;
}

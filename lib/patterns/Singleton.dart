class EmailSingleton {
  static EmailSingleton? _singleton;

  EmailSingleton._();

  static EmailSingleton getInstance() {
    _singleton ??= EmailSingleton._();

    return _singleton!;
  }

  String _email = '';
  void setEmail({required String email}) {
    _email = email;
  }

  String getEmail() => _email;
}

class UsernameSingleton {
  static UsernameSingleton? _singleton;

  UsernameSingleton._();

  static UsernameSingleton getInstance() {
   _singleton ??= UsernameSingleton._();

    return _singleton!;
  }

  String _username = '';
  void setUsername({required String username}) {
    _username = username;
  }

  String getUsername() => _username;
}

class PasswordSingleton {
  static PasswordSingleton? _singleton;

  PasswordSingleton._();

  static PasswordSingleton getInstance() {
    _singleton ??= PasswordSingleton._();

    return _singleton!;
  }

  String _password = '';
  void setPassword({required String password}) {
    _password = password;
  }

  String getPassword() => _password;
}

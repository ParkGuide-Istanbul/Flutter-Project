class EmailSingleton {
  static EmailSingleton? _singleton;

  EmailSingleton._();

  static EmailSingleton getInstance() {
    if (_singleton == null) {
      _singleton = EmailSingleton._();
    }

    return _singleton!;
  }

  String _email = '';
  void setEmail({required String email}) {
    this._email = email;
  }

  String getEmail() => this._email;
}

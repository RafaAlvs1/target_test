import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_test/models/user.dart';
import 'package:target_test/shared/constant_preferences.dart';

class Authentication {
  static Authentication? _instance;

  factory Authentication() => _instance ??= Authentication._();
  late SharedPreferences prefs;

  final _controller = StreamController<User?>.broadcast();
  User? _user;

  Authentication._() {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();

    final user = await _getStoredUser();
    _controller.add(user);
    _user = user;
  }

  Stream<User?> get authState => _controller.stream;

  Future<User?> _getStoredUser() async {
    try {
      String? storedUser = prefs.getString(ConstantPreferences.STORED_USER);

      if (storedUser != null) {
        Map<String, dynamic> jsonUser = json.decode(storedUser);
        return User.fromMap(jsonUser);
      }
    } catch (ignored) {}
    return null;
  }

  signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final map = {
      'id': '1000',
      'nome': 'TESTE',
      'email': email,
      'token': '#####',
    };

    await prefs.setString(
      ConstantPreferences.STORED_USER,
      json.encode(map),
    );

    final user = User.fromMap(map);
    _controller.add(user);
    _user = user;
  }
}

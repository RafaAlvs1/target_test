import 'dart:async';

import 'package:flutter/material.dart';
import 'package:target_test/pages/access/login_page.dart';
import 'package:target_test/pages/home/home_page.dart';
import 'package:target_test/services/authentication.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late StreamSubscription _subscription;
  late bool _isLoading;
  late bool _isLogged;
  late bool _hasError;

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _hasError = _isLogged = false;

    _subscription = Authentication().authState.listen((user) {
      _isLoading = false;
      _isLogged = user != null;
      setState(() {});
    }, onError: (error) {
      _isLogged = _isLoading = false;
      _hasError = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildWaitingScreen(context);
    }

    if (_hasError) {
      return _buildErrorScreen(context);
    }

    return _isLogged ? const HomePage() : const LoginPage();
  }

  Widget _buildWaitingScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Error!"),
      ),
    );
  }
}

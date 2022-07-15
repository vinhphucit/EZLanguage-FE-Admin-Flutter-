import 'dart:async';
import 'dart:convert';

import '../mvvm/models/session.dart';
import '../mvvm/views/splash/splash_screen.dart';
import '../repositories/remotes/exceptions/http_exception.dart';
import '../repositories/respository.dart';
import '../utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashVM extends State<SplashScreen> {
  Session? _currentSession;
  DateTime? _expiryDate;
  Timer? _refreshTokenTimer;

  bool get isAuth {
    return _currentSession != null;
  }

  Future<bool> tryAutoLogin() async {
    try {
      _currentSession = await SharedPrefUtils.getSession();
      if (_currentSession == null) return false;
      _expiryDate = DateTime.fromMillisecondsSinceEpoch(
          (_currentSession?.accessTokenExpiresAt ?? 0) * 1000);

      if (_expiryDate!.isBefore(DateTime.now())) {
        bool isRefreshTokenSuccessfully = await _tryRefreshToken();
        if (!isRefreshTokenSuccessfully) return false;
      }

      setState(() {});
    } catch (e) {
      print(e);
    }

    return true;
  }

  Future<bool> _tryRefreshToken() async {
    try {
      var refreshTokenDate = DateTime.fromMillisecondsSinceEpoch(
          _currentSession!.refreshTokenExpiresAt * 1000);
      if (refreshTokenDate != null &&
          refreshTokenDate.isBefore(DateTime.now())) {
        Session result = await Repository.getInstance()
            .refreshToken(_currentSession!.refreshToken);
        _handleNewSession(result);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _handleNewSession(Session? session) async {
    _currentSession = session;
    SharedPrefUtils.saveSession(session);
    if (session == null) {
      _expiryDate = null;
      _cancelRefreshToken();
    } else {
      _expiryDate = DateTime.fromMillisecondsSinceEpoch(
          session.accessTokenExpiresAt * 1000);
      _autoRefreshToken();
    }
  }

  void _autoRefreshToken() {
    if (_refreshTokenTimer != null) {
      _refreshTokenTimer?.cancel();
    }
    final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds;
    _refreshTokenTimer = Timer(
        Duration(seconds: timeToExpiry == null ? 0 : timeToExpiry - 60),
        _refreshToken);
  }

  void _cancelRefreshToken() {
    if (_refreshTokenTimer != null) {
      _refreshTokenTimer?.cancel();
    }
  }

  void _refreshToken() async {
    try {
      Session result = await Repository.getInstance()
          .refreshToken(_currentSession!.refreshToken);
      await _handleNewSession(result);
    } on HttpException catch (e) {
      throw (e as HttpException).toString();
    } catch (e) {
      throw e;
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

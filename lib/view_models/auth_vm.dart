import 'dart:async';
import 'dart:convert';

import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';
import 'package:fe_ezlang_admin/repositories/respository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthVM with ChangeNotifier {
  final String PREF_SESSION_KEY = 'session';
  final String PREF_SESSION_ACCESSTOKEN = 'session';
  final String PREF_SESSION_ACCESSTOKENEXPIRESIN = 'session';
  final String PREF_SESSION_REFRESHTOKEN = 'session';
  final String PREF_SESSION_REFRESHTOKENEXPIRESIN = 'session';
  Session? _currentSession;
  DateTime? _expiryDate;
  Timer? _refreshTokenTimer;

  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  void set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isAuth {
    return _currentSession != null;
  }

  String? get token {
    if (_expiryDate != null &&
        (_expiryDate?.isAfter(DateTime.now()) ?? false) &&
        _currentSession != null) {
      return _currentSession?.accessToken;
    }
    return null;
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(PREF_SESSION_KEY)) {
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString(PREF_SESSION_KEY) ?? '')
              as Map<String, dynamic>;

      _currentSession = Session.fromJson(extractedUserData);
      _expiryDate = DateTime.fromMillisecondsSinceEpoch(
          (_currentSession?.accessTokenExpiresAt ?? 0) * 1000);

      if (_expiryDate!.isBefore(DateTime.now())) {
        bool isRefreshTokenSuccessfully = await _tryRefreshToken();
        if (!isRefreshTokenSuccessfully) return false;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return true;
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading = true;
      Session result = await Repository.getInstance().signIn(email, password);
      _handleNewSession(result);
    } on HttpException catch (e) {
      throw (e as HttpException).toString();
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading = true;
      await Repository.getInstance()
          .signOut(_currentSession?.refreshToken ?? '');
    } catch (e) {
    } finally {
      _handleNewSession(null);
      isLoading = false;
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

  Future<void> _handleNewSession(Session? result) async {
    _currentSession = result;
    final prefs = await SharedPreferences.getInstance();
    if (result == null) {
      _expiryDate = null;
      prefs.remove(PREF_SESSION_KEY);
      _cancelRefreshToken();
    } else {
      _expiryDate = DateTime.fromMillisecondsSinceEpoch(
          result.accessTokenExpiresAt * 1000);
      final currentSession = json.encode(_currentSession);
      prefs.setString(PREF_SESSION_KEY, currentSession);
      _autoRefreshToken();
    }
  }

  void _cancelRefreshToken() {
    if (_refreshTokenTimer != null) {
      _refreshTokenTimer?.cancel();
    }
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
}

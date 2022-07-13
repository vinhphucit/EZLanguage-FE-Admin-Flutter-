import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../mvvm/models/session.dart';

class SharedPrefUtils {
  static final String _PREF_SESSION = 'session';
  static final String _PREF_ACCESSTOKEN = 'access_token';

  static void saveSession(Session? session) async {
    final prefs = await SharedPreferences.getInstance();
    if (session == null) {
      prefs.remove(_PREF_SESSION);
      prefs.remove(_PREF_ACCESSTOKEN);
    } else {
      final currentSession = json.encode(session);
      prefs.setString(_PREF_SESSION, currentSession);
      prefs.setString(_PREF_ACCESSTOKEN, session.accessToken);
    }
  }

  static Future<Session?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_PREF_SESSION)) {
      String? prefSession = prefs.getString(_PREF_SESSION);
      if (prefSession == null) return null;
      final extractedUserData =
          json.decode(prefs.getString(_PREF_SESSION)!) as Map<String, dynamic>;

      return Session.fromJson(extractedUserData);
    }
    return null;
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_PREF_ACCESSTOKEN)) {
      String? prefToken = prefs.getString(_PREF_ACCESSTOKEN);
      return prefToken;
    }
    return null;
  }
}

// lib/providers/user_profile_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';

class UserProfileProvider extends ChangeNotifier {
  static const String _profileKey = 'liftly_user_profile';
  UserProfile? _profile;
  bool _isLoading = true;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get hasProfile => _profile != null && _profile!.name.trim().isNotEmpty;
  String get userName => _profile?.name ?? 'Athlete';

  UserProfileProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_profileKey);
    if (jsonStr != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(jsonStr);
        _profile = UserProfile.fromJson(data);
      } catch (e) {
        debugPrint('Error loading user profile: $e');
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveProfile(UserProfile newProfile) async {
    _profile = newProfile;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(newProfile.toJson());
    await prefs.setString(_profileKey, jsonStr);
  }
}

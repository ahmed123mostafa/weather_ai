import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather_ai/feature/auth/sevices/auth_services.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authService.signUp(firstName, lastName, email, password);

      _user = _authService.getCurrentUser();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true; // Set loading to true before the sign-in request
      notifyListeners(); // Notify the UI to show the loading spinner
      await _authService.signIn(email, password);
      _user = _authService.getCurrentUser();
      _isLoading = false; // Set loading to false when request completes
      notifyListeners(); // Notify that loading is finished
    } catch (e) {
      _isLoading = false; // Set loading to false in case of error
      notifyListeners(); // Notify the UI that loading finished even if there was an error
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authService.signOut();
      _user = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}

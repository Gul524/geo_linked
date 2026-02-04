import 'package:flutter/material.dart';

/// Navigation helper utilities
class NavigationUtils {
  NavigationUtils._();

  /// Push a new route
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.of(
      context,
    ).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// Push and replace current route
  static Future<T?> pushReplacement<T, TO>(BuildContext context, Widget page) {
    return Navigator.of(
      context,
    ).pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));
  }

  /// Push and remove all routes
  static Future<T?> pushAndRemoveAll<T>(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pop current route
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  /// Pop until a specific route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }
}

/// Snackbar helper utilities
class SnackBarUtils {
  SnackBarUtils._();

  /// Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show error snackbar
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show info snackbar
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}

/// Validation helper utilities
class ValidationUtils {
  ValidationUtils._();

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}

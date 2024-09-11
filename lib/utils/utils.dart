import 'package:flutter/material.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:go_router/go_router.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isEmpty || !regex.hasMatch(value) ? 'Enter a valid email address' : null;
}

String? validatePassword(String value) {
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  if (!value.contains(RegExp(r'[a-zA-Z]'))) {
    return 'Password must contain at least one letter';
  }

  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  }

  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]'))) {
    return 'Password must contain at least one special character';
  }
  return null;
}

String? validateName(String value) {
  if (value.isEmpty) {
    return 'Name cannot be empty';
  }
  return null;
}

String? validateConfirmPassword(String password, String confirmPassword) {
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

void popUntilPath(BuildContext context, String path) {
  final router = GoRouter.of(context).routerDelegate.currentConfiguration.matches.last.matchedLocation;
  logD('router: $router');

  while (router != path) {
    if (!context.canPop()) {
      logD('Cannot pop');
      return;
    }
    context.pop();
  }
}

import 'package:flutter/material.dart';

/// Reusable input component for registration and sign-in flows.
class KopanoTextInput extends StatelessWidget {
  const KopanoTextInput({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        autocorrect: !obscureText,
        enableSuggestions: !obscureText,
      );
}

/// Consistent content width and responsive padding for form-based pages.
class KopanoFormLayout extends StatelessWidget {
  const KopanoFormLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth < 480 ? 20 : 32,
            vertical: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: child,
            ),
          ),
        ),
      );
}

/// Public format checks only; server-side identity validation is mandatory.
class KopanoFormValidation {
  static String? requiredName(String? value) =>
      (value?.trim().length ?? 0) < 2 ? 'Enter at least two characters' : null;

  static String? phone(String? value) {
    final raw = value?.trim() ?? '';
    if (!RegExp(r'^\+?[0-9 ()-]{7,20}).hasMatch(raw)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? password(String? value) =>
      (value?.length ?? 0) < 8 ? 'Use at least 8 characters' : null;
}
).hasMatch(raw)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? password(String? value) =>
      (value?.length ?? 0) < 8 ? 'Use at least 8 characters' : null;
}

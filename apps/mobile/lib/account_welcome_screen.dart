import 'package:flutter/material.dart';

import 'feature_screens.dart';
import 'main.dart';
import 'sign_in_screen.dart';

/// Public entry point into the account journey.
/// No authentication is attempted in the frontend preview.
class AccountWelcomeScreen extends StatelessWidget {
  const AccountWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Join Kopano')),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 480,
                    minHeight: (constraints.maxHeight - 52).clamp(0.0, double.infinity),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BrandMark(),
                      const SizedBox(height: 32),
                      Semantics(
                        label: 'Meet, Connect and Explore',
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(34),
                            gradient: const LinearGradient(
                              colors: [KopanoTheme.purple, KopanoTheme.pink],
                            ),
                          ),
                          child: const Icon(Icons.favorite, size: 75, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Belong. Connect. Explore.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: KopanoTheme.ink,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Meet new people, make friends, and find places and events across Lesotho.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 26),
                      KopanoAction(
                        label: 'Explore onboarding',
                        icon: Icons.explore_outlined,
                        onPressed: () => openPreview(context, const OnboardingScreen()),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () => openPreview(context, const SignInScreen()),
                        icon: const Icon(Icons.login),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text('Sign in'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => openPreview(context, const RegistrationScreen()),
                        child: const Text('Create an account'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'For adults aged 18+. Preview only — account creation and login are disabled.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

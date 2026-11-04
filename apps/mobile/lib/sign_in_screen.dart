import 'package:flutter/material.dart';
import 'main.dart';
import 'feature_screens.dart';
import 'ui_components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final key = GlobalKey<FormState>();
  final phone = TextEditingController();
  final password = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Sign in')),
        body: SafeArea(
          child: KopanoFormLayout(
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: BrandMark()),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                      color: KopanoTheme.ink,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text('Connect with your community.'),
                  const SizedBox(height: 25),
                  KopanoTextInput(
                    controller: phone,
                    label: 'Phone number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    validator: KopanoFormValidation.phone,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    key: const Key('sign-in-password'),
                    controller: password,
                    obscureText: !showPassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.password],
                    validator: KopanoFormValidation.password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        tooltip: showPassword ? 'Hide password' : 'Show password',
                        icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => showPassword = !showPassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  KopanoAction(
                    label: 'Sign in (preview)',
                    icon: Icons.login,
                    onPressed: () {
                      if (!(key.currentState?.validate() ?? false)) return;
                      showDemo(context, 'Sign in');
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => openPreview(context, const RegistrationScreen()),
                    child: const Text('Create a new account'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Demonstration only. Credentials are never submitted or stored.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

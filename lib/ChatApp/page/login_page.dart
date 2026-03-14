import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/my_button.dart';
import '../component/my_text_field.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign in user
  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.message, size: 60),
                const SizedBox(height: 20),
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 15),
                myTextField(
                  hintText: 'Email',
                  labelText: 'Email',
                  controller: emailController,
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                myTextField(
                  hintText: 'Password',
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ButtonWidget(text: 'Sign In', onTap: signIn),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


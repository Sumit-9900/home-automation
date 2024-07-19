import 'package:flutter/material.dart';
import 'package:home_automation/provider/auth_provider.dart';
import 'package:home_automation/screens/bottom_nav_page.dart';
import 'package:home_automation/services/utils/messages.dart';
import 'package:home_automation/widgets/containerr.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Image.asset(
                'assets/images/room.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Control Your Home\n Easily',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Manage your home from anytime, anywhere',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your password';
                            } else if (passController.text.trim().length < 6) {
                              return 'Password should be minimum of 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Containerr(
                          text: authProvider.isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : authProvider.isLogin
                                  ? Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              authProvider.isLogin
                                  ? await authProvider.logIn(
                                      emailController.text.trim(),
                                      passController.text.trim())
                                  : await authProvider.signUp(
                                      emailController.text.trim(),
                                      passController.text.trim(),
                                    );
                              if (authProvider.mssg != null &&
                                  context.mounted) {
                                errorMssg(context, authProvider.mssg!);
                              } else if (!authProvider.isLoading &&
                                  context.mounted) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => const BottomNavPage(),
                                  ),
                                );
                                successMssg(
                                    context,
                                    authProvider.isLogin
                                        ? 'Logged in successfully'
                                        : 'Signed up successfully!!!');
                              }
                            }
                            emailController.clear();
                            passController.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          authProvider.isLogin
                              ? 'Don\'t have an account yet?'
                              : 'Already have an account?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            authProvider.isLoginn();
                          },
                          child: Text(
                            authProvider.isLogin
                                ? 'Create an account'
                                : 'Login your account',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

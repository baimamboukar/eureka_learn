import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(authProvider).state;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(gradient: Palette.linearGradient),
        child: RefreshIndicator(
          onRefresh: () {
            return _auth.loginUser(
                mail: emailController.text, pass: passwordController.text);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0) +
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text("🤓", style: TextStyle(fontSize: 64.0)),
                    Logo(
                      withIcon: false,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText("Hack your success now",
                            speed: const Duration(milliseconds: 100),
                            cursor: "⚡"),
                      ],
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      repeatForever: true,
                    ),
                    const SizedBox(height: 30.0),
                    Input(
                      icon: LineIcons.userAlt,
                      context: context,
                      type: TextInputType.text,
                      controller: emailController,
                      label: "username",
                      hint: "Enter your username",
                      isPassword: false,
                      isPhone: false,
                    ),
                    Input(
                        icon: LineIcons.lock,
                        context: context,
                        type: TextInputType.text,
                        controller: passwordController,
                        label: "password",
                        hint: "Enter your password",
                        isPassword: true,
                        isPhone: false),
                    const SizedBox(height: 10.0),
                    Text("Forgot your password ?",
                        style: TextStyle(color: Palette.error)),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        _auth
                            .loginUser(
                                mail: emailController.text,
                                pass: passwordController.text)
                            .then((user) {
                          Navigator.pop(context);
                          context.refresh(authStateProvider);
                        });
                      },
                      child: Button(
                        label: "Login",
                        icon: LineIcons.signature,
                        color: Palette.primary,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Divider(
                      height: 1.0,
                    ),
                    // const SizedBox(height: 20.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Button(
                    //       label: "With Google",
                    //       icon: LineIcons.googleLogo,
                    //       color: Palette.error.withOpacity(0.7),
                    //     ),
                    //     Button(
                    //       label: "With Phone",
                    //       icon: LineIcons.tablet,
                    //       color: Palette.success,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () => Get.to(() => Signup()),
                      child: Text("Don't have account? Sign Up there...",
                          style: TextStyle(
                              color: Palette.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

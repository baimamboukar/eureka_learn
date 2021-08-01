import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Signup extends HookWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authProvider);
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(gradient: Palette.linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0) +
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
              children: [
                Text("🤓", style: TextStyle(fontSize: 64.0)),
                Logo(
                  withIcon: false,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("Hack your success now",
                        speed: const Duration(milliseconds: 100), cursor: "⚡"),
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
                    controller: nameController,
                    label: "name",
                    hint: "enter your names",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: Icons.email,
                    context: context,
                    type: TextInputType.text,
                    controller: emailController,
                    label: "email",
                    hint: "enter your email",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.mobilePhone,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
                    label: "phone number",
                    hint: "Enter your phone number",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.lock,
                    context: context,
                    type: TextInputType.text,
                    controller: passwordController,
                    label: "password",
                    hint: "Enter your password",
                    isPassword: true,
                    isPhone: false),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    auth.signupUser(
                        mail: emailController.text,
                        pass: passwordController.text);
                  },
                  child: Button(
                    label: "Signup",
                    icon: LineIcons.userPlus,
                    color: Palette.primary,
                  ),
                ),
                const SizedBox(height: 20.0),
                Divider(
                  height: 1.0,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      label: "With Google",
                      icon: LineIcons.googleLogo,
                      color: Palette.error.withOpacity(0.7),
                    ),
                    Button(
                      label: "With Phone",
                      icon: LineIcons.tablet,
                      color: Palette.success,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => Get.to(() => Login()),
                  child: Text("Already have account? Login here...",
                      style: TextStyle(
                          color: Palette.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

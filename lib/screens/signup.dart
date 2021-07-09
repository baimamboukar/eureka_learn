import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Signup extends HookWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authProvider);
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
                    controller: TextEditingController(),
                    label: "name",
                    hint: "Enter your names",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.inbox,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
                    label: "email",
                    hint: "Enter your email",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.phoneSquare,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
                    label: "phone",
                    hint: "Enter your phone number",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.lock,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
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
                    auth.signUp(
                        email: "lorem.ipsum@jock.me", password: "Shooter_8113");
                  },
                  child: Button(
                    label: "Signup",
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
                      label: "With Google 🔗",
                      color: Palette.error.withOpacity(0.7),
                    ),
                    Button(
                      label: "With Phone 📲",
                      color: Palette.success,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text("Already have account? Login here...",
                    style: TextStyle(
                        color: Palette.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

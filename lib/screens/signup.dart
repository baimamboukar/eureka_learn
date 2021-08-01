import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final registrationInfosProvider = StateProvider<bool>((ref) => false);
final sectionProvider = StateProvider<String>((ref) => "");
final classeProvider = StateProvider<String>((ref) => "");

class Signup extends HookWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authProvider);
    final registrationInfos = useProvider(registrationInfosProvider);
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
            child: registrationInfos.state
                ? RegistrationInfos()
                : Form(
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
                            isPhone: false,
                            validator: (value) => !GetUtils.isEmail(value!)
                                ? "Enter a valid email please"
                                : null),
                        Input(
                            icon: LineIcons.mobilePhone,
                            context: context,
                            type: TextInputType.text,
                            controller: TextEditingController(),
                            label: "phone number",
                            hint: "Enter your phone number",
                            isPassword: false,
                            isPhone: false,
                            validator: (value) =>
                                !GetUtils.isPhoneNumber(value!)
                                    ? "Enter a valid phone number"
                                    : null),
                        Input(
                            icon: LineIcons.lock,
                            context: context,
                            type: TextInputType.text,
                            controller: passwordController,
                            label: "password",
                            hint: "Enter your password",
                            isPassword: true,
                            isPhone: false,
                            validator: (value) {
                              if (value!.length < 6)
                                return "Your password should have at least 6 characters";
                              else
                                return null;
                            }),
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate())
                              registrationInfos.state = true;
                            // auth.signupUser(
                            //     mail: emailController.text,
                            //     pass: passwordController.text);
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
                                  color: Palette.primary,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      )),
    );
  }
}

class RegistrationInfos extends HookWidget {
  RegistrationInfos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = useProvider(sectionProvider);
    final classe = useProvider(classeProvider);
    return Column(
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
        Divider(),
        Text("What is your section?", style: Styles.subtitle),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => section.state = "Anglophone",
              child: Chip(
                backgroundColor: section.state == "Anglophone"
                    ? Palette.primary.withOpacity(0.8)
                    : Colors.grey,
                avatar: Icon(LineIcons.signature),
                label: Text("Anglophone"),
                side: BorderSide(
                    color: section.state == "Anglophone"
                        ? Palette.primary.withOpacity(0.8)
                        : Colors.grey,
                    width: 2.0),
              ),
            ),
            GestureDetector(
              onTap: () => section.state = "Francophone",
              child: Chip(
                  backgroundColor: section.state == "Francophone"
                      ? Palette.primary.withOpacity(0.8)
                      : Colors.grey,
                  avatar: Icon(LineIcons.fileSignature),
                  label: Text("Francophone"),
                  side: BorderSide(
                      color: section.state == "Francophone"
                          ? Palette.primary.withOpacity(0.8)
                          : Colors.grey,
                      width: 2.0)),
            ),
          ],
        ),
        Text("What is your class?", style: Styles.subtitle),
        if (section.state != "" && classe.state == "")
          Container(
            height: 250.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                final _classe = classes[index];
                return Card(
                  color: classe.state == _classe
                      ? Palette.primary
                      : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: ListTile(
                    onTap: () => classe.state = _classe,
                    title: Text(_classe),
                    trailing: classe.state == _classe
                        ? Icon(LineIcons.checkCircleAlt, color: Palette.light)
                        : SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
        if (classe.state != "")
          Card(
            color: Palette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: ListTile(
                title: Text(classe.state),
                trailing: Icon(LineIcons.checkCircleAlt, color: Palette.light)),
          ),
        Text("What are your subjects ?", style: Styles.subtitle),
        Wrap(spacing: 3.50, children: [
          for (int i = 0; i < 15; i++)
            Chip(
              label: Text("Geography"),
            )
        ])
      ],
    );
  }
}

List<String> classes = [
  "1ere TI",
  "Tle TI",
  "Tle C",
  "Tle D",
  "Tle A4 ESP",
  "Tle A4 All"
];

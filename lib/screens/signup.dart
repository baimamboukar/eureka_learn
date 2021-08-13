import 'package:animate_do/animate_do.dart';
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
import 'package:line_icons/line_icons.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final registrationInfosProvider = StateProvider<bool>((ref) => false);
final sectionProvider = StateProvider<String>((ref) => "");
final classeProvider = StateProvider<String>((ref) => "");
final subjectsProvider = StateProvider<List<String>>((ref) => []);
final levelProvider = StateProvider<String>((ref) => "");

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
                            label: "Continue...",
                            icon: LineIcons.signature,
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

class RegistrationInfos extends StatefulHookWidget {
  RegistrationInfos({Key? key}) : super(key: key);

  @override
  _RegistrationInfosState createState() => _RegistrationInfosState();
}

class _RegistrationInfosState extends State<RegistrationInfos> {
  @override
  Widget build(BuildContext context) {
    final section = useProvider(sectionProvider);
    final level = useProvider(levelProvider);
    final classe = useProvider(classeProvider);

    final chosenSubjects = useProvider(subjectsProvider);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            section.state = "";
            classe.state = "";
            chosenSubjects.state = [];
          },
          child: Button(
            color: Palette.primary,
            label: "Reset",
            icon: LineIcons.signature,
          ),
        ),
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
        if (section.state != "" &&
            section.state == "Anglophone" &&
            classe.state == "")
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Text("What is your level?", style: Styles.subtitle),
          ),
        if (section.state != "" &&
            section.state == "Anglophone" &&
            classe.state == "")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => level.state = "Ordinary",
                child: Chip(
                  backgroundColor: section.state == "Anglophone"
                      ? Palette.primary.withOpacity(0.8)
                      : Colors.grey,
                  avatar: Icon(LineIcons.barChartAlt),
                  label: Text("Ordinary"),
                  side: BorderSide(
                      color: section.state == "Anglophone"
                          ? Palette.primary.withOpacity(0.8)
                          : Colors.grey,
                      width: 2.0),
                ),
              ),
              GestureDetector(
                onTap: () => level.state = "Advanced",
                child: Chip(
                    backgroundColor: section.state == "Francophone"
                        ? Palette.primary.withOpacity(0.8)
                        : Colors.grey,
                    avatar: Icon(LineIcons.barChart),
                    label: Text("Advanced"),
                    side: BorderSide(
                        color: section.state == "Francophone"
                            ? Palette.primary.withOpacity(0.8)
                            : Colors.grey,
                        width: 2.0)),
              ),
            ],
          ),
        if (level.state != "" && classe.state == "")
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Text("What is your class?", style: Styles.subtitle),
          ),
        if (section.state != "" && classe.state == "")
          FlipInY(
            duration: Duration(milliseconds: 1750),
            child: Container(
              height: 250.0,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: section.state == "Francophone"
                    ? francoClasses.length
                    : angloClasses.length,
                itemBuilder: (BuildContext context, int index) {
                  final _classe = section.state == "Francophone"
                      ? francoClasses[index]
                      : angloClasses[index];
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
          ),
        if (classe.state != "")
          FadeIn(
            duration: Duration(milliseconds: 1200),
            child: Card(
              color: Palette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: ListTile(
                  title: Text(classe.state),
                  trailing:
                      Icon(LineIcons.checkCircleAlt, color: Palette.light)),
            ),
          ),
        if (classe.state != "")
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text("What are your subjects ?", style: Styles.subtitle),
          ),
        if (classe.state != "")
          FlipInX(
            duration: Duration(milliseconds: 1500),
            delay: Duration(milliseconds: 1200),
            child: Wrap(
                spacing: 3.50,
                children: section.state == "Francophone"
                    ? francoSubjects
                        .map((subject) => JelloIn(
                              child: ChoiceChip(
                                selected:
                                    chosenSubjects.state.contains(subject),
                                onSelected: (selected) {
                                  selected
                                      ? chosenSubjects.state.add(subject)
                                      : chosenSubjects.state.remove(subject);
                                  setState(() {});
                                },
                                label: Text(subject),
                              ),
                            ))
                        .toList()
                    : angloSubjects
                        .map((subject) => JelloIn(
                              child: ChoiceChip(
                                selected:
                                    chosenSubjects.state.contains(subject),
                                onSelected: (selected) {
                                  selected
                                      ? chosenSubjects.state.add(subject)
                                      : chosenSubjects.state.remove(subject);
                                  setState(() {});
                                },
                                label: Text(subject),
                              ),
                            ))
                        .toList()),
          ),
        if (chosenSubjects.state.length >= 3)
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: FadeIn(
              duration: Duration(milliseconds: 2000),
              child: Button(
                label: "Continue...",
                icon: LineIcons.signature,
                color: Palette.primary,
              ),
            ),
          )
      ],
    );
  }
}

List<String> francoClasses = [
  "1ere TI",
  "Tle TI",
  "Tle C",
  "Tle D",
  "Tle A4 ESP",
  "Tle A4 All"
];

List<String> angloClasses = [
  "From 5S",
  "From 5C",
  "From 5A",
  "From 5SP",
  "USS",
  "USA",
];

List<String> angloSubjects = [
  "Maths",
  "Physics",
  "Econmics",
  "Geography",
  "Computer Science",
  "ICT",
  "Maths",
  "Physics",
  "Econmics",
  "Geography",
  "Computer Science",
  "ICT"
];
List<String> francoSubjects = [
  "Maths",
  "Physique",
  "Litterature",
  "ESF",
  "Chimie",
  "Informatique",
  "Maths",
  "Physique",
  "Litterature",
  "ESF",
  "Chimie",
  "Informatique"
];

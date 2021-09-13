import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:line_icons/line_icons.dart';

class Profile extends HookWidget {
  final Student user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(user.names)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 38.0,
                                    backgroundImage: AssetImage(
                                        "assets/icons/png/student.png"),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(user.names,
                                          style: Styles.designText(
                                              bold: true,
                                              color: Palette.primary,
                                              size: 24.0)),
                                      const SizedBox(height: 8.0),
                                      Text("student at ${user.school}"),
                                      const SizedBox(height: 5.0),
                                      Text(user.email),
                                    ],
                                  )
                                ],
                              ),
                              Wrap(
                                spacing: 1.5,
                                children: user.subjects
                                    .map((subject) => Chip(
                                          backgroundColor:
                                              Palette.primary.withOpacity(0.5),
                                          label: Text(subject,
                                              style: Styles.designText(
                                                  bold: false,
                                                  size: 12.0,
                                                  color: Palette.dark)),
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Icon(LineIcons.medal,
                                    size: 38.0, color: Palette.secondary),
                                Text("Brave Achiever")
                              ],
                            ),
                            Column(
                              children: [
                                Icon(LineIcons.trophy,
                                    size: 38.0, color: Palette.dark),
                                Text("Best Achievement")
                              ],
                            ),
                            Column(
                              children: [
                                Icon(LineIcons.certificate,
                                    size: 38.0, color: Colors.brown),
                                Text("Exams winner")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  decoration:
                      BoxDecoration(color: Palette.primary.withOpacity(0.25))),
              const SizedBox(height: 25.0),
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  /// Banner image
                  Container(
                    height: 130.0,
                    padding: EdgeInsets.only(top: 28),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/icons/png/eureka.png"),
                    )),
                  ),

                  /// UserModel avatar, message icon, profile edit and follow/following button
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle),
                          child: GestureDetector(
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/icons/png/student.png"),
                              radius: 30,
                            ),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 90, right: 30),
                          child: Row(
                            children: <Widget>[
                              Container(height: 40),
                              SizedBox(width: 10)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton:
            FloatingActionButton(onPressed: null, child: Icon(LineIcons.edit)),
      ),
    );
  }
}

import 'package:eureka_learn/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final Student user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 200.0,
              stretch: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        radius: 18.0,
                        backgroundImage:
                            AssetImage("assets/icons/png/student.png")),
                    const SizedBox(width: 4.0),
                    Text(
                      user.names,
                      style: GoogleFonts.josefinSans(fontSize: 15.0),
                    ),
                  ],
                ),
                background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/icons/png/philosophy.png"))),
                    child: Column(
                      children: [],
                    )),
              )),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
                    CircleAvatar(child: Text("B"), radius: 18.0),
                    const SizedBox(width: 4.0),
                    Text(
                      "Baimam Boukar",
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

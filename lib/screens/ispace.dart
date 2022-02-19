// ignore: unused_import
import 'package:eureka_learn/providers/user_provider.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:eureka_learn/widgets/popular_topics.dart';
import 'package:eureka_learn/widgets/posts.dart';
import 'package:eureka_learn/widgets/top_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ispace extends HookWidget {
  get post => null;
  final student = useProvider(studentControllerProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: student.student.prenium,
      replacement: Purchase(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Discussion Board",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Find discussions on subjects you like to read",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.0),
                        topRight: Radius.circular(35.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBar(),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Popular Topics",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    PopularTopics(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                      child: Text(
                        "Trending Posts",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Posts()
                  ],
                ))
          ],
        )),
      ),
    );
  }
}

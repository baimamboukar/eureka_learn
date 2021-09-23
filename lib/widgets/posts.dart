import 'package:eureka_learn/models/post_model%20copy.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:eureka_learn/models/post_model.dart';
import 'package:eureka_learn/screens/post_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: questions
            .map((question) => GestureDetector(
                  onTap: () => Get.to(() => PostScreen(
                        question: question,
                      )),
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.05),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/icons/png/student.png"),
                                      radius: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(question.question,
                                                style: Styles.designText(
                                                    bold: false,
                                                    color: Palette.dark,
                                                    size: 18.0)),
                                          ),
                                          SizedBox(height: 2.0),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                question.author.name,
                                                style: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                question.created_at,
                                                style: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: FaIcon(FontAwesomeIcons.bookmark),
                                  color: Colors.grey.withOpacity(0.6),
                                  iconSize: 26,
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                "${question.content.substring(0, 80)}..",
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.thumbsUp,
                                      color: Colors.grey.withOpacity(0.6),
                                      size: 22,
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "${question.votes} votes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: FaIcon(
                                        FontAwesomeIcons.envelopeOpenText),
                                    color: Colors.grey.withOpacity(0.6),
                                    iconSize: 16,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "${question.repliesCount} replies",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: FaIcon(FontAwesomeIcons.eye),
                                    color: Colors.grey.withOpacity(0.6),
                                    iconSize: 18,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    "${question.views} views",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.6)),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            .toList());
  }
}

import 'package:eureka_learn/models/author_model.dart';
import 'package:eureka_learn/models/replies_model.dart';

class Question {
  String question;
  String content;
  int votes;
  int repliesCount;
  int views;
  // ignore: non_constant_identifier_names
  String created_at;
  Author author;
  List<Reply> replies;

  Question(
      {required this.question,
      required this.content,
      required this.votes,
      required this.repliesCount,
      required this.views,
      // ignore: non_constant_identifier_names
      required this.created_at,
      required this.author,
      required this.replies});
}

List<Question> questions = [
  Question(
      author: mike,
      question: "lorem ipsum dolor",
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "1h ago",
      views: 120,
      votes: 100,
      repliesCount: 80,
      replies: replies),
  Question(
      author: john,
      question: "lorem ipsum dolor si amet",
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "2h ago",
      views: 20,
      votes: 10,
      repliesCount: 10,
      replies: replies),
  Question(
      author: sam,
      question: "Lorem ipsum dolor",
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "4h ago",
      views: 220,
      votes: 107,
      repliesCount: 67,
      replies: replies),
  Question(
      author: mark,
      question: "loremson ipsumson",
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "10h ago",
      views: 221,
      votes: 109,
      repliesCount: 67,
      replies: replies),
  Question(
      author: justin,
      question: "lorem ipsum question",
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "24h ago",
      views: 325,
      votes: 545,
      repliesCount: 120,
      replies: replies),
];

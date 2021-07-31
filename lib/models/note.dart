class Note {
  final String subject;
  final List<Topic> topics;

  Note({required this.subject, required this.topics});
}

class Topic {
  final String title;
  final String intro;
  final List<dynamic> content;

  Topic({required this.title, required this.intro, required this.content});
}

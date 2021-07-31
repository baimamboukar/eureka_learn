class Note {
  final String subject;
  final List<Topic> topics;
  final String? author;
  final String classe;
  Note(
      {required this.subject,
      required this.topics,
      required this.classe,
      this.author});
}

class Topic {
  final String title;
  final String intro;
  final List<dynamic> content;

  Topic({required this.title, required this.intro, required this.content});
}

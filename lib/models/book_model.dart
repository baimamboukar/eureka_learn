class BookModel {
  final String name;
  final String subject;
  final String? imagePath;
  final String url;
  final String? author;
  final List<String>? tags;

  BookModel(
      {required this.subject,
      required this.name,
      this.imagePath,
      required this.url,
      this.author,
      this.tags});
}

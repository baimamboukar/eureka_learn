class QuestionModel {
  final String question;
  final String answer;
  final List<String> options;
  final String? image;
  final String subject;
  final String topic;
  final String? selectedOption;

  QuestionModel(
      {required this.question,
      this.selectedOption,
      required this.answer,
      required this.options,
      this.image,
      required this.subject,
      required this.topic});
}

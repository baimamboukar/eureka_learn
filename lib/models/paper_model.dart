import 'dart:convert';

class PaperModel {
  final String subject;
  final String type;
  final String? from;
  final String since;
  final String link;
  final String level;
  final int downloadCOunt;

  PaperModel({
    required this.subject,
    required this.level,
    required this.type,
    required this.from,
    required this.since,
    required this.link,
    required this.downloadCOunt,
  });

  PaperModel copyWith({
    String? subject,
    String? type,
    String? from,
    String? since,
    String? link,
    int? downloadCOunt,
  }) {
    return PaperModel(
      subject: subject ?? this.subject,
      type: type ?? this.type,
      from: from ?? this.from,
      since: since ?? this.since,
      link: link ?? this.link,
      level: level,
      downloadCOunt: downloadCOunt ?? this.downloadCOunt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'type': type,
      'from': from,
      'since': since,
      'link': link,
      'downloadCOunt': downloadCOunt,
      'level': level
    };
  }

  factory PaperModel.fromDocumentSnapshot(Map<String, dynamic> map) {
    return PaperModel(
      level: map['level'],
      subject: map['subject'] ?? '',
      type: map['type'] ?? '',
      from: map['from'],
      since: map['since'] ?? '',
      link: map['link'] ?? '',
      downloadCOunt: map['downloadCOunt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaperModel.fromJson(String source) =>
      PaperModel.fromDocumentSnapshot(json.decode(source));

  @override
  String toString() {
    return 'PaperModel(subject: $subject, type: $type, from: $from, since: $since, link: $link, downloadCOunt: $downloadCOunt)';
  }
}

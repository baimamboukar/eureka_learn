import 'package:eureka_learn/models/models.dart';

import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';

List<Note> notes = [
  Note(subject: "Maths", classe: "From 5", topics: [
    Topic(
        title: "Arithmetic in Z",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Biology", classe: "From 5", topics: [
    Topic(
        title: "Genetics and human legacy",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Csc", classe: "From 5", topics: [
    Topic(
        title: "Basic Data structures",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Physics", classe: "From 5", topics: [
    Topic(
        title: "Harmonic Oscillators",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ]),
    Topic(
        title: "Newton Laws",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ]),
    Topic(
        title: "Differential Equations",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Geography", classe: "From 5", topics: [
    Topic(
        title: "Volcanism",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "CitizenShip Education", classe: "From 5", topics: [
    Topic(
        title: "Arithmetic in Z",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
];
List<PaperModel> papers = [
  PaperModel(
      from: "GBHSM",
      subject: "Physics",
      since: DateTime.parse("2021-05-28"),
      type: "2nd Sequence"),
  PaperModel(
      from: "Lykama",
      subject: "Csc",
      since: DateTime.parse("2028-04-18"),
      type: "4th Sequence"),
  PaperModel(
      from: "Xv Vogt",
      subject: "Philosophy",
      since: DateTime.parse("2021-05-28"),
      type: "Mock Exam"),
  PaperModel(
      from: "CMGHSM",
      subject: "Geography",
      since: DateTime.parse("2021-05-28"),
      type: "4th Sequence"),
  PaperModel(
      from: "CMGHSM",
      subject: "Biology",
      since: DateTime.parse("2021-05-28"),
      type: "3rd Sequence"),
  PaperModel(
      from: "OBC",
      subject: "Maths",
      since: DateTime.parse("2021-05-28"),
      type: "2022 Exam"),
];
List<LabelModel> subjects = [
  LabelModel(title: "All", iconPath: "🔥", active: false),
  LabelModel(title: "Chemistry", iconPath: "🌡️", active: false),
  LabelModel(title: "Geo", iconPath: "🌍", active: false),
  LabelModel(title: "Biology", iconPath: "🔬", active: false),
  LabelModel(title: "Maths", iconPath: "📈", active: false),
  LabelModel(title: "Csc", iconPath: "💻", active: false),
  LabelModel(title: "Physics", iconPath: "🚀", active: false),
  LabelModel(title: "Philosophy", iconPath: "📚", active: false),
];

var imagesRosot = "assets/icons/png";
List<SubjectBox> subjectsBox = [
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Maths",
      imagePath: "$imagesRosot/maths.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Biology",
      imagePath: "$imagesRosot/biology.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Geography",
      imagePath: "$imagesRosot/geography.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "FurtherMaths",
      imagePath: "$imagesRosot/maths.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Geography",
      imagePath: "$imagesRosot/geography.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Philosophy",
      imagePath: "$imagesRosot/philosophy.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Physics",
      imagePath: "$imagesRosot/atom.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Economics",
      imagePath: "$imagesRosot/philosophy.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "CitizenShip",
      imagePath: "$imagesRosot/philosophy.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Csc",
      imagePath: "$imagesRosot/atom.png"),
];

List<PostModel> posts = [
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Mathematically",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerName: "Winner pro",
      timeAgo: "2 days",
      label: "Lorem ipsum dolor si met do set consectur",
      ownerId: "5851e9fncsovzumc",
      ownerLevel: "ordinary",
      comments: ["Waouh", "Meme situation", "Good question"],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Computer Science",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerLevel: "advanced",
      ownerName: "Myra Sika",
      label:
          "How to write an algorithm with algoBox without time ellapsed property",
      timeAgo: "3 days",
      ownerId: "5851e9fncsovzumc",
      comments: [
        "Solved issue at stackExchange.com",
        "Same here",
        "Can't wait to see it fixed"
      ],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Mathematically",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerLevel: "ordinary",
      ownerName: "Winner pro",
      timeAgo: "2 days",
      label: "Lorem ipsum dolor si met do set consectur",
      ownerId: "5851e9fncsovzumc",
      comments: ["Waouh", "Meme situation", "Good question"],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Computer Science",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerLevel: "ordinary",
      ownerName: "Myra Sika",
      label:
          "How to write an algorithm with algoBox without time ellapsed property",
      timeAgo: "3 days",
      ownerId: "5851e9fncsovzumc",
      comments: [
        "Solved issue at stackExchange.com",
        "Same here",
        "Can't wait to see it fixed"
      ],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Mathematically",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerName: "Winner pro",
      timeAgo: "2 days",
      label: "Lorem ipsum dolor si met do set consectur",
      ownerId: "5851e9fncsovzumc",
      ownerLevel: "ordinary",
      comments: ["Waouh", "Meme situation", "Good question"],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: true,
      inGroup: true,
      group: "Computer Science",
      photoURL: "assets/icons/png/biology.png",
      ownerAvatar: "assets/icons/png/student.png",
      ownerName: "Myra Sika",
      label:
          "How to write an algorithm with algoBox without time ellapsed property",
      timeAgo: "3 days",
      ownerId: "5851e9fncsovzumc",
      ownerLevel: "ordinary",
      comments: [
        "Solved issue at stackExchange.com",
        "Same here",
        "Can't wait to see it fixed"
      ],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
];

// final QuizzModel quizz = QuizzModel(
//   state: QuizzState.initial,
//   questions: [
//     QuestionModel(
//         question: "Lorem ipsum dolor sit amet, consectetur",
//         answer: "Lorem ipsum dolor",
//         options: ["Alpha option", "Beta Option", "Delta Option"],
//         subject: "Maths",
//         selectedOption: null,
//         topic: ''),
//     QuestionModel(
//         question: "Lorem ipsum dolor sit amet, consectetur",
//         answer: "Lorem ipsum dolor",
//         options: ["Alpha option", "Beta Option", "Delta Option"],
//         subject: "Maths",
//         selectedOption: null,
//         topic: ''),
//     QuestionModel(
//         question: "Lorem ipsum dolor sit amet, consectetur",
//         answer: "Lorem ipsum dolor",
//         options: ["Alpha option", "Beta Option", "Delta Option"],
//         subject: "Maths",
//         image: "assets/images/",
//         selectedOption: null,
//         topic: ''),
//     QuestionModel(
//         question: "Lorem ipsum dolor sit amet, consectetur",
//         answer: "Lorem ipsum dolor",
//         options: ["Alpha option", "Beta Option", "Delta Option"],
//         subject: "Maths",
//         image: "assets/images/",
//         selectedOption: null,
//         topic: ''),
//     QuestionModel(
//         question: "Lorem ipsum dolor sit amet, consectetur",
//         answer: "Lorem ipsum dolor",
//         options: ["Alpha option", "Beta Option", "Delta Option"],
//         subject: "Maths",
//         image: "assets/images/",
//         selectedOption: null,
//         topic: ''),
//   ],
//   subject: "Geograpy",
//   topic: "Volcanism",
//   timed: false,
//   isGeneralQuizz: false,
// );

List<BookModel> books = [
  BookModel(
      name: "True Love waits",
      subject: "Literature",
      imagePath: "assets/icons/png/cover1.jpg",
      author: "Pochi Tamba",
      tags: ["Love", "HIV", "Youth"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "CIAM 1ere SM",
      subject: "Maths",
      imagePath: "assets/icons/png/cover2.jpg",
      author: "CIAM",
      tags: ["Maths", "Physics", "Thinking"],
      url: "http://firebase-storage/bucket-magic/ciam-1ere.pdf"),
  BookModel(
      name: "Excellenz in Physics",
      subject: "Physics",
      imagePath: "assets/icons/png/cover5.jpg",
      author: "Simo Eric",
      tags: ["Physics", "Laws", "Planets"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Balafon",
      subject: "Literature",
      imagePath: "assets/icons/png/cover2.jpg",
      author: "Engelbert Mveng",
      tags: ["Patriotism", "faith", "heroism"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Algorithms done right",
      subject: "Csc",
      imagePath: "assets/icons/png/cover1.jpg",
      author: "Al Khwarizmi",
      tags: ["Algorithms", "Thinking", "Programs"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Covid19: The Grand Tour",
      subject: "Biology",
      imagePath: "assets/icons/png/cover1.jpg",
      author: "ICT-U",
      tags: ["Covid19", "Pandemic", "Population"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Evolutionisme",
      subject: "Biology",
      imagePath: "assets/icons/png/cover1.jpg",
      author: "Charles Darwin",
      tags: ["Creation", "Evolution", "Population"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Python3: The Grand Tour",
      subject: "Csc",
      imagePath: "assets/icons/png/cover2.jpg",
      author: "Guido Van Rossum",
      tags: ["Coding", "Python", "Programming"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Trigonomagic",
      subject: "Maths",
      imagePath: "assets/icons/png/cover5.jpg",
      author: "Perellman",
      tags: ["Solving", "Caluculus", "Maths"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "E=mc2",
      subject: "Physics",
      imagePath: "assets/icons/png/cover1.jpg",
      author: "Albert Einstein",
      tags: ["Thinking", "World", "Relativity"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Zarathousthra was telling",
      subject: "Philosophy",
      imagePath: "assets/icons/png/cover4.jpg",
      author: "Friedrich Nietsche",
      tags: ["Humanity", "Wisdom", "Philosophy"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Apology of Socratis",
      subject: "Phylosophy",
      imagePath: "assets/icons/png/cover2.jpg",
      author: "Platon",
      tags: ["Wisdom", "Life", "Thinking"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
  BookModel(
      name: "Methamorphism",
      subject: "Geography",
      imagePath: "assets/icons/png/cover5.jpg",
      author: "Hatier Int",
      tags: ["Geography", "Geology", "Metamorphism"],
      url: "http://firebase-storage/bucket-magic/tlw.pdf"),
];

List<String> francoClasses = [
  "1ere TI",
  "1ere C",
  "1ere D",
  "1ere E",
  "Tle TI",
  "Tle C",
  "Tle D",
  "Tle E",
  "Tle A4 ESP",
  "Tle A4 ARB",
  "Tle A4 ITL",
  "Tle A4 CHN",
  "Tle PEBS",
  "Tle A4 All"
];

List<String> angloSeries = [
  "Science 1",
  "Science 2",
  "Science 3",
  "Science 4 ",
  "Science 5",
  "Science 6 ",
  "Science 7",
  "Science 8 ",
  "Arts 1",
  "Arts 2",
  "Arts 3",
  "Arts 4",
  "Arts 5",
];

List<String> angloSubjects = [
  "Maths",
  "Physics",
  "Economics",
  "Geography",
  "History",
  "Chemistry",
  "French",
  "English",
  "Literature",
  "Philosophy",
  "Biology",
  "Philosophy",
  "Computer Science",
  "Pure Maths",
  "Further Maths",
  "ICT"
];
List<String> francoSubjects = [
  "Maths",
  "Physique",
  "Litterature",
  "Anglais",
  "Chimie",
  "Informatique",
  "Etude des cas",
  "SI",
  "SVT",
  "Philosophie",
  "Allemand",
  "Espagnol",
  "Chinois",
  "Langue",
  "Italien",
  "Arabe"
];

List<String> a1 = ["Literature", "History", "French"];
List<String> a2 = ["History", "Geography", "Economics"];
List<String> a3 = ["History", "Economics", "Literature"];
List<String> a4 = ["Economics", "Geography", "Pure Maths"];
List<String> a5 = ["Literature", "History", "Philosophy"];

List<String> s1 = ["Chemistry", "Physics", "Pure Maths"];
List<String> s2 = ["Chemistry", "Physics", "Biology"];
List<String> s3 = ["Biology", "Chemistry", "Pure Maths"];

List<String> s4 = ["Biology", "Biology", "Pure Maths"];
List<String> s5 = ["Chemistry", "Computer Science", "Maths"];
List<String> s6 = ["Chemistry", "Physics", "Maths", "Further Maths"];
List<String> s7 = ["Chemistry", "Biology", "Physics", "Maths"];
List<String> s8 = ["Chemistry", "Biology", "Physics", "Maths", "Further Maths"];

List<String> tagsCloud =
    (a1 + a2 + a3 + a4 + a5 + s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8)
        .toSet()
        .toList();

// models/fact.dart
class Fact {
  final int id;
  final String title;
  final String category;
  final String body;
  final int grade;

  Fact({this.id = 0, required this.title, required this.category, required this.body, this.grade = 0});

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      body: json['body'],
      grade: json['grade'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'body': body,
        'grade': grade,
      };
}
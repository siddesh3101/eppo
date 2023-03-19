class Trending {
  final String title;
  final String director;
  final int year;

  Trending({
    required this.title,
    required this.director,
    required this.year,
  });

  factory Trending.fromJson(Map<String, dynamic> json) {
    return Trending(
      title: json['title'],
      director: json['director'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'director': director,
      'year': year,
    };
  }
}

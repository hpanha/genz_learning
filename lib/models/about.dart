class About {
  final int id;
  final String image;

  About({required this.id, required this.image});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      id: json['id'],
      image: json['image'],
    );
  }
}

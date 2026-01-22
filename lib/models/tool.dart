class Tool {
  final int id;
  final String image;

  Tool({required this.id, required this.image});

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
      id: json['id'],
      image: json['image'],
    );
  }
}

class SliderItem {
  final int id;
  final String image;

  SliderItem({required this.id, required this.image});

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      id: json['id'],
      image: json['image'],
    );
  }
}

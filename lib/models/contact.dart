class Contact {
  final int id;
  final String name;
  final String email;
  final String subject;
  final String message;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subject: json['subject'],
      message: json['message'],
    );
  }
}

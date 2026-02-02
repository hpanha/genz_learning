import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact.dart';

class ContactService {
  static const String apiUrl =
      'https://www.genzcoder.dev/api-data-contact';

  static Future<List<Contact>> fetchContacts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List data = body['data'];
      return data.map((e) => Contact.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}

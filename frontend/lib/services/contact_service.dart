import 'dart:convert';
import 'package:frontend/models/contact.dart';
import 'package:http/http.dart' as http;

class ContactService {
  final String baseUrl = 'http://your-api-url/api/contacts';

  Future<List<Contact>> getContacts(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Contact.fromJson(json)).toList();
    }
    return [];
  }

  Future<Contact?> createContact(Contact contact, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 201) {
      return Contact.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // Implement other CRUD operations (update, delete)
}

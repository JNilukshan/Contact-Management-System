import 'package:flutter/material.dart';
import 'package:frontend/models/contact.dart';
import 'package:frontend/services/contact_service.dart';

class AddContactScreen extends StatefulWidget {
  final String token;

  AddContactScreen({required this.token});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final ContactService _contactService = ContactService();

  void _saveContact() async {
    final contact = Contact(
      id: '',
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
    );
    final newContact =
        await _contactService.createContact(contact, widget.token);
    if (newContact != null) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create contact."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

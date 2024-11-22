import 'package:flutter/material.dart';
import 'package:frontend/models/contact.dart';
import 'package:frontend/services/contact_service.dart';
import 'add_contact_screen.dart';

class ContactsListScreen extends StatefulWidget {
  final String token;

  ContactsListScreen({required this.token});

  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final ContactService _contactService = ContactService();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    final contacts = await _contactService.getContacts(widget.token);
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddContactScreen(token: widget.token),
                ),
              ).then((_) => _loadContacts());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.email),
            onTap: () {
              // Navigate to contact detail screen if implemented
            },
          );
        },
      ),
    );
  }
}

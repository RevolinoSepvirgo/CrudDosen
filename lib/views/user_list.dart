import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart'; // Tetap pakai model yang sudah kamu buat

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(); // Panggil fungsi ambil data
  }

  // Fungsi ambil data dari API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8000/api/users")); // Ganti sesuai IP-mu

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List usersJson = data['users'];
      return usersJson.map((json) => User.fromJson(json)).toList(); // Gunakan model dari UserModel.dart
    } else {
      throw Exception('Gagal memuat data user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Daftar User'),
        backgroundColor: Color(0xFF2C3E50),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final users = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                color: Colors.white,
                elevation: 4,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF2C3E50),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34495E), // Warna tulisan elegan
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDosenScreen extends StatefulWidget {
  @override
  _AddDosenScreenState createState() => _AddDosenScreenState();
}

class _AddDosenScreenState extends State<AddDosenScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  Future<void> createDosen() async {
    final response = await http.post(
      Uri.parse("http://172.20.10.4:8000/api/dosen"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nip': nipController.text,
        'nama_lengkap': namaController.text,
        'no_telepon': telpController.text,
        'email': emailController.text,
        'alamat': alamatController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data dosen berhasil ditambahkan")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menambahkan data dosen")),
      );
    }
  }

  InputDecoration buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("Tambah Dosen"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nipController,
                decoration: buildInputDecoration("NIP", Icons.badge),
                validator: (value) => value!.isEmpty ? "NIP wajib diisi" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: namaController,
                decoration: buildInputDecoration("Nama Lengkap", Icons.person),
                validator: (value) => value!.isEmpty ? "Nama wajib diisi" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: telpController,
                decoration: buildInputDecoration("No Telepon", Icons.phone),
                validator: (value) => value!.isEmpty ? "No telepon wajib diisi" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: buildInputDecoration("Email", Icons.email),
                validator: (value) => value!.isEmpty ? "Email wajib diisi" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: alamatController,
                decoration: buildInputDecoration("Alamat", Icons.home),
                validator: (value) => value!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createDosen();
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      Navigator.pop(context, true); // Kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data dosen berhasil ditambahkan")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menambahkan data dosen")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Dosen"),
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
                decoration: InputDecoration(labelText: "NIP"),
                validator: (value) => value!.isEmpty ? "NIP wajib diisi" : null,
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: "Nama Lengkap"),
                validator: (value) => value!.isEmpty ? "Nama wajib diisi" : null,
              ),
              TextFormField(
                controller: telpController,
                decoration: InputDecoration(labelText: "No Telepon"),
                validator: (value) => value!.isEmpty ? "No telepon wajib diisi" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Email wajib diisi" : null,
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: "Alamat"),
                validator: (value) => value!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createDosen();
                  }
                },
                child: Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

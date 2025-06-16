import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/DosenModel.dart';

class EditDosenScreen extends StatefulWidget {
  final Dosen dosen;

  EditDosenScreen({required this.dosen});

  @override
  _EditDosenScreenState createState() => _EditDosenScreenState();
}

class _EditDosenScreenState extends State<EditDosenScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nipController;
  late TextEditingController namaController;
  late TextEditingController telpController;
  late TextEditingController emailController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    nipController = TextEditingController(text: widget.dosen.nip);
    namaController = TextEditingController(text: widget.dosen.namaLengkap);
    telpController = TextEditingController(text: widget.dosen.noTelepon);
    emailController = TextEditingController(text: widget.dosen.email);
    alamatController = TextEditingController(text: widget.dosen.alamat);
  }

  Future<void> updateDosen() async {
    final response = await http.put(
      Uri.parse("http://172.20.10.4:8000/api/dosen/${widget.dosen.no}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nip': nipController.text,
        'nama_lengkap': namaController.text,
        'no_telepon': telpController.text,
        'email': emailController.text,
        'alamat': alamatController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true); // Berhasil edit, kembali
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data dosen berhasil diperbarui")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memperbarui data dosen")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Dosen"),
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
                    updateDosen();
                  }
                },
                child: Text("Update"),
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

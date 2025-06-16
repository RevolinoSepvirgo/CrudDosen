import 'package:flutter/material.dart';
import '../models/DosenModel.dart';

class DosenDetailScreen extends StatelessWidget {
  final Dosen dosen;

  DosenDetailScreen({required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Dosen'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailItem(Icons.person, "Nama Lengkap", dosen.namaLengkap),
                detailItem(Icons.badge, "NIP", dosen.nip),
                detailItem(Icons.phone, "No. Telepon", dosen.noTelepon),
                detailItem(Icons.email, "Email", dosen.email),
                detailItem(Icons.home, "Alamat", dosen.alamat),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: "$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

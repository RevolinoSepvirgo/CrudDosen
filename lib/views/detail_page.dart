import 'package:flutter/material.dart';
import '../models/UserModel.dart';

class DetailPage extends StatelessWidget {
  final User user;

  const DetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
        backgroundColor: Color(0xFF2C3E50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("👤 Nama     : ${user.name}", style: detailText()),
                SizedBox(height: 10),
                Text("📧 Email    : ${user.email}", style: detailText()),
                SizedBox(height: 10),
                Text("📱 Telepon  : ${user.phone}", style: detailText()),
                SizedBox(height: 10),
                Text("🏷️ Jabatan  : ${user.jabatan}", style: detailText()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle detailText() {
    return TextStyle(fontSize: 18, color: Color(0xFF34495E));
  }
}

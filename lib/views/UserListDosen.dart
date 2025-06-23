import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_lumen/views/CreateDosen.dart';
import '../models/DosenModel.dart';
import 'DetailDosen.dart';
import 'EditDosen.dart'; // Pastikan file ini ada

class DosenListScreen extends StatefulWidget {
  @override
  _DosenListScreenState createState() => _DosenListScreenState();
}

class _DosenListScreenState extends State<DosenListScreen> {
  late Future<List<Dosen>> futureDosen;

  @override
  void initState() {
    super.initState();
    futureDosen = fetchDosen();
  }

  Future<List<Dosen>> fetchDosen() async {
    final response = await http.get(Uri.parse("http://172.20.10.4:8000/api/dosen"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Dosen.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data dosen');
    }
  }

  Future<void> deleteDosen(int no) async {
    final response = await http.delete(Uri.parse("http://172.20.10.4:8000/api/dosen/$no"));

    if (response.statusCode == 200) {
      setState(() {
        futureDosen = fetchDosen(); // Refresh data
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data berhasil dihapus")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal menghapus data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Dosen", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Dosen>>(
        future: futureDosen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final dosenList = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.only(bottom: 80),
            itemCount: dosenList.length,
            itemBuilder: (context, index) {
              final dosen = dosenList[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Hapus Dosen"),
                        content: Text("Yakin ingin menghapus ${dosen.namaLengkap}?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              deleteDosen(dosen.no);
                            },
                            child: Text("Hapus", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.teal),
                    title: Text(
                      dosen.namaLengkap,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("NIP: ${dosen.nip}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DosenDetailScreen(dosen: dosen),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.orange),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditDosenScreen(dosen: dosen),
                          ),
                        );
                        if (result == true) {
                          setState(() {
                            futureDosen = fetchDosen();
                          });
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "addDosen",
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddDosenScreen()),
          );
          if (result == true) {
            setState(() {
              futureDosen = fetchDosen(); // Refresh data setelah tambah
            });
          }
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}

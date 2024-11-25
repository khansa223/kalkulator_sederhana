import 'package:flutter/material.dart';

void main() {
  runApp(NilaiSiswaApp());
}

class NilaiSiswaApp extends StatefulWidget {
  @override
  _NilaiSiswaAppState createState() => _NilaiSiswaAppState();

}

class _NilaiSiswaAppState extends State<NilaiSiswaApp> {
  
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelompokan Nilai Siswa',
      theme: ThemeData.light(), // Mode terang
      darkTheme: ThemeData.dark(), // Mode gelap
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        onThemeChanged: (bool isDarkMode) {
          setState(() {
            _isDarkMode = isDarkMode;
          });
        },
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final bool isDarkMode;
  

  const HomePage({required this.onThemeChanged, required this.isDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String _kategori = '';
  String _errorMessage = '';

  void _hitungKategori() {
    setState(() {
      _errorMessage = '';
      int? nilai = int.tryParse(_controller.text);

      if (nilai == null || nilai < 0 || nilai > 100) {
        _errorMessage = 'Masukkan nilai yang valid antara 0 hingga 100';
        _kategori = '';
      } else if (nilai >= 85) {
        _kategori = 'A';
      } else if (nilai >= 70) {
        _kategori = 'B';
      } else if (nilai >= 55) {
        _kategori = 'C';
      } else {
        _kategori = 'D';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelompokan Nilai Siswa'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Nilai Siswa (0-100)',
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitungKategori,
              child: Text('Hitung'),
            ),
            SizedBox(height: 20), 
            Text(
              _kategori.isEmpty ? '' : 'Kategori: $_kategori',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

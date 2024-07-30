import 'package:flutter/material.dart';

class Savedoctor extends StatefulWidget {
  @override
  _SavedoctorState createState() => _SavedoctorState();
}

class _SavedoctorState extends State<Savedoctor> {
  bool _isChecked = false; // Checkbox'ın durumu
  bool _isIlceFilled = false; // İlçe alanının doldurulup doldurulmadığını kontrol

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 8),
                Text('Kimlik Bilgileri', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Text('Aile Hekimi Değilim'),
              ],
            ),
            SizedBox(height: 15),
            textbar('Adı'),
            SizedBox(height: 10),
            textbar('Soyadı'),
            SizedBox(height: 10),
            textbar('TC Kimlik No'),
            SizedBox(height: 10),
            textbar('ÇKYS Kodu'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'İlçe',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isIlceFilled = value.isNotEmpty;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    enabled: _isIlceFilled,
                    decoration: InputDecoration(
                      labelText: 'İl',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (_isChecked == false) ...[
              textbar('A.H. Birim Numarası'),
            ],
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft, 
              child: Text(
                '* Tüm alanların doldurulması zorunludur',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
                },
                child: Text('Kaydet'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textbar(String text) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: text,
        hintText: '...',
        border: OutlineInputBorder(),
      ),
    );
  }
}



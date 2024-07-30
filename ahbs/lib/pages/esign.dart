import 'package:flutter/material.dart';

class esign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'PIN Numaranızı Giriniz',
                  hintText: '...',
                  prefixIcon: Icon(Icons.sms),
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Gönder'))
          ],
        ),
      ),
    );
  }
}
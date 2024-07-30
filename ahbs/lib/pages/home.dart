import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
// ignore: unused_import
import 'dart:convert';
import 'savedoctor.dart';
import 'LoginScreen.dart';
import 'esign.dart';

// Kerem Döleksöz

Widget iconandtext(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: Colors.black),
      SizedBox(width: 8),
      Text(text),
    ],
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // Sunucuya göndereceğimiz URL
    final url = Uri.parse('https://ahbs.sisoft.com.tr/sisoft/LoginMan.do');

    // Gönderilecek veriler
    final data = {
      'uskod': _emailController.text,
      'pwd': _passwordController.text,
    };

    // POST isteği gönderme
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'czmfunction': 'doLogin',
        'Czmformno': '1608',
      },
      body: data,
    );

    // Gelen yanıtı işleme
    if (response.statusCode == 200) {
      // Yanıtı konsola yazdırma
      print('Yanıt: ${response.body}');

      // Yanıt gövdesini XML olarak ayrıştırma
      final document = xml.XmlDocument.parse(response.body);
      final codeElement = document.findAllElements('code').first;

      // Yanıtın içeriğine göre işlem yapma
      if (codeElement.text == '1') {
        // İstek başarılı olduysa giriş ekranına yönlendirme
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Yanıttan hata mesajı alma
        final errorMessage = 'Hatalı kullanıcı adı veya parola';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      // Yanıtı konsola yazdırma
      print('Yanıt: ${response}');

      // Bir hata oluştuysa kullanıcıya bildirme
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geçersiz e-posta veya şifre')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Aile Hekimliği Bilgi Sistemi',
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Form(
              child: Row(
                children: [
                  Image.asset('assets/leftheader.png'),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  Text(
                      "Türkiye'nin en hızlı gelişen aile hekimliği bilgi sistemine hoşgeldiniz. Kullanıcı bilgileriniz ile sisteme giriş yapabilirsiniz"),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      hintText: 'E-postanızı girin',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Parola',
                      hintText: 'Parolanızı girin',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lütfen E-posta adresinizi giriniz')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Yeni Şifreniz SMS Olarak İletildi')),
                      );
                    }
                  },
                  icon: Icon(Icons.question_mark, color: Colors.grey),
                  label: Text(
                    'Şifremi Unuttum ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => esign(),
                      ),
                    );
                  },
                  child: Text('E-İmza'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    fixedSize: Size(150, 65),
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
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Giriş'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    fixedSize: Size(150, 65),
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
              ],
            ),
            SizedBox(height: 15),
            Image.asset('assets/line.png'),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/rightheader.png'),
            ),
            Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                iconandtext(Icons.check, 'İşletim sistemi bağımsızlığı'),
                iconandtext(Icons.check, 'İnternet tarayıcı bağımsızlığı'),
                iconandtext(Icons.check, 'Hızlı erişim sağlayan akıllı menü'),
                iconandtext(Icons.check, 'Anlık performans takip sistemi'),
                iconandtext(Icons.check, 'Aile bireylerini otomatik tanıma'),
                iconandtext(Icons.check, 'İnsan modeli üzerinden bulgu ekleyebilme'),
              ],
            ),
            SizedBox(height: 20),
            Image.asset('assets/line.png'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Savedoctor(), // Use the imported Savedoctor class
                      ),
                    );
                  },
                  icon: Icon(Icons.account_box_outlined, color: Colors.grey),
                  label: Text(
                    'Yeni Hekim Kaydet ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 35,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

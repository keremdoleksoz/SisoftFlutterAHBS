import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToUrl();
  }

  Future<void> _redirectToUrl() async {
    const url = 'https://www.sisoft.com.tr/tr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
      body: Center(
        child: Text("Sisteme Başarıyla Giriş Yaptınız"),
      ),
    );
  }
}



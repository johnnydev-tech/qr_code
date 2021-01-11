import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitor QR Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Leitor QR Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _captureQR() async{
    String scan = await scanner.scan();

    // scan.then((qrText) {
    //   _showDialog(qrText);
    // });
    _showDialog(scan);
  }
  _launchURL(String qr) async {
    String url = qr;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  void _showDialog(String qrText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Link do QR CODE"),
            content: Text(qrText),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Colors.red,
                child: Text("Fechar"),
              ),
              FlatButton(
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: () {
                 _launchURL(qrText);
                },
                child: Text("Abrir"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(child: Text("Ler QR Code"),
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                textColor: Colors.white,
                color: Colors.indigo,
                onPressed: () {
                  _captureQR();
                })
          ],
        ),
      ),

    );
  }
}

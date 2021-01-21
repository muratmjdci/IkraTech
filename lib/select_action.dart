import 'package:qrscan/qrscan.dart' as scanner;
import 'package:IkraTechnologies/actions.dart';
import 'package:IkraTechnologies/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class SelectActionPage extends StatefulWidget {
  String data;
  @override
  _SelectActionPageState createState() => _SelectActionPageState();
}

class _SelectActionPageState extends State<SelectActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.red,
    title: Text("IKRA"),
    centerTitle: true,
  );
}

Center buildBody(BuildContext context) {
  String data;
  Future<void> scanQrCode(context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'İptal',
      true,
      ScanMode.QR,
    );
    if (qrCode != "") {
      data = qrCode;
    } else {
      showToast(context, "QR Kod bulunamadı.");
    }
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultButton(
          text: "Kameradan QR Kodu Okut",
          onPressed: () {
            scanQrCode(context).then((val) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActionPage(
                                data: data,
                              )))
                });
          },
        ),
        DefaultButton(
          text: "Galeriden QR Kodu Okut",
          onPressed: () async {
            final filePicker = ImagePicker();
            final pickedQr =
                await filePicker.getImage(source: ImageSource.gallery);
            await scanner.scanPath(pickedQr.path).then((val) => {
                  if (val != null)
                    {
                      data = val,
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActionPage(
                                    data: data,
                                  )))
                    }
                });
          },
        )
      ],
    ),
  );
}

void showToast(BuildContext context, message) {
  return Toast.show(message, context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
}

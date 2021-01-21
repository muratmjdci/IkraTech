import 'dart:convert';
import 'package:IkraTechnologies/result_page.dart';
import 'package:http/http.dart' as http;
import 'package:IkraTechnologies/default_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ActionPage extends StatefulWidget {
  final data;
  ActionPage({this.data});
  @override
  _ActionPageState createState() => _ActionPageState(data: data);
}

class _ActionPageState extends State<ActionPage> {
  final String data;
  _ActionPageState({this.data});
  var phoneMask = new MaskTextInputFormatter(
      mask: '(###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  var idMask = new MaskTextInputFormatter(
      mask: '### ### ### ##', filter: {"#": RegExp(r'[0-9]')});
  var plateMask =
      new MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-8]')});
  var plate1Mask = new MaskTextInputFormatter(
      mask: '#####', filter: {"#": RegExp(r'[0-9]')});
  var jobMask = new MaskTextInputFormatter(filter: {"#": RegExp(r'[a-z]')});

  final plate1 = TextEditingController();
  final plate2 = TextEditingController();
  final job = TextEditingController();
  final id = TextEditingController();
  final phone = TextEditingController();
  String apiUrl = "https://web1.inscockpit.com/test";
  bool sifirArac = false;
  bool runOnce = true;
  @override
  Widget build(BuildContext context) {
    var data = jsonDecode(widget.data);
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          if (runOnce)
            {
              plate1.text = data['plate1'],
              plate2.text = data['plate2'],
              job.text = data['job'],
              id.text = data['identity'],
              phone.text = data['phone'],
              runOnce = false,
            }
        });
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.8,
          child: Column(
            children: [
              Expanded(flex: 20, child: buildCheckBox()),
              Expanded(
                flex: 20,
                child: buildTextField(
                    hintText: "Kimlik No", control: id, format: idMask),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: buildTextField(
                          hintText: 'İl Kodu',
                          control: plate1,
                          format: plate1Mask)),
                  Spacer(),
                  Expanded(
                      flex: 6,
                      child: buildTextField(
                          hintText: "Plaka",
                          control: plate2,
                          format: plateMask)),
                ],
              ),
              Spacer(),
              Expanded(
                  flex: 20,
                  child: buildTextField(
                      hintText: "Meslek", control: job, format: jobMask)),
              Spacer(),
              Expanded(
                flex: 20,
                child: buildTextField(
                    hintText: "Cep Telefonu",
                    control: phone,
                    format: phoneMask),
              ),
              Spacer(),
              Expanded(
                flex: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DefaultButton(
                    onPressed: () {
                      sendReq();
                    },
                    text: "Teklif al",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ); // widget tree
  }

  Padding buildTextField({@required hintText, control, format}) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextField(
            inputFormatters: [format],
            controller: control,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: hintText,
            )));
  }

  CheckboxListTile buildCheckBox() {
    return CheckboxListTile(
      title: Text("Sıfır Araç"),
      value: sifirArac,
      onChanged: (val) {
        setState(() {
          sifirArac = val;
        });
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Araç Sigortası"),
      backgroundColor: Colors.red,
    );
  }

  sendReq() {
    var postData = {
      "identity": id.text.toString(),
      "job": job.text.toString(),
      "phone": phone.text.toString(),
      "plate1": plate1.text.toString(),
      "plate2": plate2.text.toString()
    };
    http.post(apiUrl, body: jsonEncode(postData)).then((response) => {
          if (response.statusCode == 200)
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(result: response.body)))
            }
        });
  }
}

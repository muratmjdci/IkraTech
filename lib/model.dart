import 'dart:convert';

QrModel welcomeFromJson(String str) => QrModel.fromJson(json.decode(str));

String welcomeToJson(QrModel data) => json.encode(data.toJson());

class QrModel {
  QrModel({
    this.identity,
    this.job,
    this.phone,
    this.plate1,
    this.plate2,
  });

  String identity;
  String job;
  String phone;
  String plate1;
  String plate2;

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
        identity: json["identity"],
        job: json["job"],
        phone: json["phone"],
        plate1: json["plate1"],
        plate2: json["plate2"],
      );

  Map<String, dynamic> toJson() => {
        "identity": identity,
        "job": job,
        "phone": phone,
        "plate1": plate1,
        "plate2": plate2,
      };
}

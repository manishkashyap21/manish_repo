import 'dart:convert';

class LoginREsponseModel {
  late bool success;
  late int statusCode;
  late String code;
  late String message;
  late Data data;

  LoginREsponseModel(
      {required this.success,
      required this.statusCode,
      required this.message,
      required this.code,
      required this.data});

  LoginREsponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['statusCode'] = statusCode;
    data['message'] = message;

    // ignore: unnecessary_null_comparison
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
  }
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String firstname;
  String displayName;
  String lastname;

  Data(
      {required this.token,
      required this.id,
      required this.email,
      required this.nicename,
      required this.firstname,
      required this.displayName,
      required this.lastname});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    nicename = json['nicename'];
    firstname = json['firstname'];
    displayName = json['displayName'];
    lastname = json['lastname'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['email'] = email;
    data['nicename'] = nicename;
    data['firstname'] = firstname;
    data['displayName'] = displayName;
    data['lastname'] = lastname;
    return data;
  }
}

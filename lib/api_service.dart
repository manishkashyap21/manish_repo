import 'dart:convert';
import 'dart:io';
import 'package:grassnut/config.dart';
import 'package:grassnut/models/customer.dart';
import 'package:dio/dio.dart';
import 'package:grassnut/models/login_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode("${Config.key}:${Config.secret}"),
    );

    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginREsponseModel> loginCustomer(
      String username, String password) async {
    LoginREsponseModel model;
    try {
      var response = await Dio().post(
        Config.tokenURl,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        model = LoginREsponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }
}

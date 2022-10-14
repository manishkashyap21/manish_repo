// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:grassnut/api_service.dart';
import 'package:grassnut/models/customer.dart';
import 'package:grassnut/utils/progressHUD.dart';
import 'package:grassnut/utils/form_helper.dart';
import 'package:grassnut/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidepassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = APIService();
    model = CustomerModel(
        email: '', firstname: '', lastname: '', password: '', username: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    var key;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: true,
        title: const Text("Sign Up"),
      ),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: key,
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                  context,
                  model.firstname,
                  (value) => {
                    // ignore: unnecessary_this
                    this.model.firstname = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter First name.";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  model.lastname,
                  (value) => {
                    model.lastname = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter Last name.";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email"),
                FormHelper.textInput(
                  context,
                  model.email,
                  (value) => {
                    model.email = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter email.";
                    }
                    if (value.isNotEmpty && !value.toString().isValidEmail()) {
                      return "Please enter valid email id";
                    }
                    return null;
                  },
                  prefixIcon: null,
                  suffixIcon: null,
                ),
                FormHelper.fieldLabel("Username"),
                FormHelper.textInput(
                  context,
                  model.username,
                  (value) => {
                    model.username = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter username.";
                    }
                    return null;
                  },
                  prefixIcon: null,
                  suffixIcon: null,
                ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {
                    model.password = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter Password.";
                    }
                    return null;
                  },
                  obscureText: hidepassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidepassword = !hidepassword;
                      });
                    },
                    color: Theme.of(context).backgroundColor.withOpacity(0.6),
                    icon: Icon(
                      hidepassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  prefixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton(
                    "Register",
                    () {
                      if (validateAndSave()) {
                        print(model.toJson());
                        setState(() {
                          isApiCallProcess = true;
                        });
                        apiService.createCustomer(model).then(
                          (ret) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            if (ret) {
                              FormHelper.showMessage(
                                context,
                                "Grassnut",
                                "Registration Successfull",
                                "ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              FormHelper.showMessage(context, "Grassnut",
                                  "Registartion failed", "ok", () {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

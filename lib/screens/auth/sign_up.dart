import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/auth/create_user_request.dart';
import 'package:jobsearchmobile/models/auth/login_request.dart';
import 'package:jobsearchmobile/models/auth/register_request.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../constants/api.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late String password;
  late String email;
  late String first;
  late String last;

  final String logoAssetPath = "assets/images/logo.png";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  tooltip: 'Go back',
                  enableFeedback: true,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    logoAssetPath,
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "First",
              "First",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'First Name can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                first = onSavedVal,
              },
              initialValue: "",
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Last",
              "Last",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Last Name can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                last = onSavedVal,
              },
              initialValue: "",
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Email",
              "Email",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                email = onSavedVal,
              },
              initialValue: "",
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
                  (onSavedVal) => {
                password = onSavedVal,
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
                  () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  RegisterRequestModel model = RegisterRequestModel(
                    first: first,
                    last: last,
                    email: email,
                    password: password,
                    isAdmin: false,
                  );

                  APIService.register(model).then((response) {
                    if (response.data != null) {
                      // Call the create user to firestore
                      CreateUserRequestModel cuModel = CreateUserRequestModel(
                          userId: response.data!.id,
                          fullName: response.data!.first + " " + response.data!.last);

                      APIService.createUserForFb(cuModel).then((response2) {
                        if (response2.post == 'success') {
                          LoginRequestModel lrModel = LoginRequestModel(
                              email: email, password: password);
                          APIService.login(lrModel).then((response) {
                              setState(() {
                                isApiCallProcess = false;
                              });

                              if (response) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/resume',
                                      (route) => false,
                                );
                              } else {
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  Api.appName,
                                  "Failed to login user",
                                  "OK",
                                      () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                          );
                        }
                        else {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            Api.appName,
                            "Failed to register user to firestore",
                            "OK",
                                () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Api.appName,
                        "Failed to register user to mongodb",
                        "OK",
                            () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  }
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Already have an account? ',
                    ),
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            '/login',
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

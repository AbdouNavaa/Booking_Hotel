import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend/models/login_request_model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../config.dart';
import '../home/home_page.dart';
class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  late SharedPreferences sharedPreferences;

  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  // String? email;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),

    ));
  }
  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70)
                )
            ),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth /3,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenHeight / 20,
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                vertical: screenWidth /100,
                horizontal: screenWidth / 100
            ),
            child: FormHelper.inputFieldWidget(context,"username", "Username",
                    (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Username can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              username = onSavedVal;
            },
                borderColor: Colors.black,
                prefixIconColor: Colors.black,
                borderFocusColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.7),
                textColor: Colors.black,
                borderRadius: 15,
                suffixIcon: Icon(Icons.person, color: Colors.black,),
                contentPadding: screenHeight /40

            ),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 100),
            child: FormHelper.inputFieldWidget(context,"password", "Password", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Password can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              password = onSavedVal;
            },
                borderColor: Colors.black,
                prefixIconColor: Colors.black,
                borderFocusColor: Colors.black,
                // hintColor: Colors.black,
                textColor: Colors.black,
                borderRadius: 15,
                hintColor: Colors.black.withOpacity(0.7),
                contentPadding: screenHeight /40,
                obscureText: hidePassword,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                }, icon: Icon(hidePassword? Icons.visibility_off:Icons.visibility,color: Colors.black,)),
                backgroundColor: Colors.white.withOpacity(0.7)
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 5),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    children: [
                      TextSpan(
                          text: 'Forget Password ?',
                          style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            print("Forget Password");
                          }
                      )
                    ]
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // width: 350,
                  child: FormHelper.submitButton(
                      "Login", (){
                        print(username.toString()+" "+password.toString());
                    if(validateAndSave()){
                      setState(() {
                        isAPIcallProcess = true;
                        LoginRequestModel model = LoginRequestModel(username: username!, password: password!);
                        print(model.username+" "+model.password+" From call");

                      });
                      LoginRequestModel model = LoginRequestModel(username: username!, password: password!);
                      print(model.username+" "+model.password+" From call");
                      APIService.login(model).then((response) => {
                        setState(() {
                          isAPIcallProcess = false;
                          print(response.toString());

                        }),
                        if(response){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(Username: username,)),
                      )
                    } else{
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "Invalide Username/Password",
                              "OK",
                                  (){
                                Navigator.pop(context);
                              }
                          )
                        }
                      });
                    }

                  },
                      btnColor:  Colors.black,
                      borderColor: Colors.black,
                      txtColor: Colors.white,
                      borderRadius: 40
                  )),
              // SizedBox(height: 10,),
              Container(
                // width: 350,
                  child: FormHelper.submitButton(
                    "Register", (){
                    Navigator.pushNamed(context,"/register");
                  },
                    btnColor:  Colors.black,
                    borderColor: Colors.black,
                    txtColor: Colors.white,
                    borderRadius: 40,
                  )),
            ],
          )

        ],
      ),
    );
  }

  bool validateAndSave(){
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{return false;}
  }
}
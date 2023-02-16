import 'package:flutter/material.dart';
import 'package:frontend/models/register_request_model.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter/gestures.dart';

import '../config.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password1;
  String? password2;
  String? email;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _registerUI(context),
        ),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),

    ));
  }
  Widget _registerUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height /3,
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             Colors.white,
          //             Colors.white,
          //           ]
          //       ),
          //       borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(100),
          //         bottomRight: Radius.circular(100),
          //       )
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Align(
          //         alignment: Alignment.center,
          //         child: Image.asset("images/two.png",
          //           width: 250,
          //           ),
          //       ),
          //
          //     ],
          //   ),
          // ),
          Container(
            height: screenHeight / 3,
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
              'Register',
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 100
            ),
            child: FormHelper.inputFieldWidget(context,"username", "Username", (onValidateVal){
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
              contentPadding: screenHeight /40,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 100
            ),
            child: FormHelper.inputFieldWidget(context,"password", "Password", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Password can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              password1 = onSavedVal;
            },
                borderColor: Colors.black,
                prefixIconColor: Colors.black,
                borderFocusColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.7),
                textColor: Colors.black,
                borderRadius: 15,
                contentPadding: screenHeight /40,
                obscureText: hidePassword,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                }, icon: Icon(hidePassword? Icons.visibility_off:Icons.visibility, color: Colors.black,)),
                backgroundColor: Colors.white.withOpacity(0.7)
            ),
          ),

          SizedBox(height: 10,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 100
            ),

            child: FormHelper.inputFieldWidget(context,"passwordConf", "PasswordConf", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Password can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              password2 = onSavedVal;
            },

                borderColor: Colors.black,
                textColor: Colors.black,
                borderFocusColor: Colors.black,

                borderRadius: 15,
                hintColor: Colors.black.withOpacity(0.7),
                obscureText: hidePassword,
                contentPadding: screenHeight /40,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                }, icon: Icon(hidePassword? Icons.visibility_off:Icons.visibility, color: Colors.black,)),
                backgroundColor: Colors.white.withOpacity(0.7)
            ),
          ),

          SizedBox(height: 10,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 100
            ),
           child: FormHelper.inputFieldWidget(context,"email", "Email", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Email can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              email = onSavedVal;
            },
                borderColor: Colors.black,
                prefixIconColor: Colors.white,
                borderFocusColor: Colors.black,
                hintColor: Colors.black,
                textColor: Colors.black,
                borderRadius: 15,
                suffixIcon: Icon(Icons.mail_outline, color: Colors.black,),
             contentPadding: screenHeight /40,
            ),
          ),


          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                  child: FormHelper.submitButton(
                      "Register", (){
    if(validateAndSave()){
    setState(() {
    isAPIcallProcess = true;
    });
    RegisterRequestModel model = RegisterRequestModel(username: username!, password1: password1!,email: email!, password2: password2!,);

    APIService.register(model).then((response) => {
    setState(() {
    isAPIcallProcess = true;
    }),
    if(response.data != null){
      FormHelper.showSimpleAlertDialog(
          context, Config.appName, "Registeration Successfull. Please login to the account.",
          "OK",
              (){
            Navigator.pushNamedAndRemoveUntil(context, '/login',
                  (route) => false,
            );
          }
      ),
    } else{
    FormHelper.showSimpleAlertDialog(
    context, Config.appName,response.message,
    "OK",
    (){
    Navigator.pop(context);}
    )}
    });
    }
                  },
                      btnColor:  Colors.black,
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      width: 320,
                      borderRadius: 120
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


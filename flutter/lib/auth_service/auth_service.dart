// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class AuthService {
//   final registrationUri = Uri.parse("http://10.0.2.2:8000/registration/");
//   final loginUri = Uri.parse("http://10.0.2.2:8000/accounts/login/");
//
//   Future<RegistrationResponse?> registration(
//       String username, String password1, String password2, String email) async {
//     var response = await http.post(registrationUri, body: {
//       "username": username,
//       "password1": password1,
//       "password2": password2,
//       "email": email,
//     });
//     // print(response.body);
//     return RegistrationResponse.formJson(jsonDecode(response.body));
//   }
//
//   Future<LogniResponse?> login(String usernameOremail, String password) async {
//     var response = await http.post(loginUri,
//         body: {"username": usernameOremail, "password": password});
//     print(response.body);
//     return LogniResponse.formJson(jsonDecode(response.body));
//   }
// }
//
// class RegistrationResponse {
//   List<dynamic>? non_field_errors;
//   List<dynamic>? password1;
//   List<dynamic>? username;
//   List<dynamic>? email;
//   dynamic? Key;
//
//   RegistrationResponse({
//     this.email,
//     this.Key,
//     this.non_field_errors,
//     this.password1,
//     this.username,
//   });
//
//   factory RegistrationResponse.formJson(mapOfBody) {
//     return RegistrationResponse(
//       email: mapOfBody['email'],
//       Key: mapOfBody['Key'],
//       non_field_errors: mapOfBody['non_field_errors'],
//       password1: mapOfBody['password1'],
//       username: mapOfBody['username'],
//     );
//   }
// }
//
// class LogniResponse {
//   dynamic? Key;
//   List<dynamic>? non_field_errors;
//   LogniResponse({this.Key, this.non_field_errors});
//
//   factory LogniResponse.formJson(mapOfBody) {
//     return LogniResponse(
//         Key: mapOfBody['Key'], non_field_errors: mapOfBody['non_field_errors']);
//   }
// }
//
//
// ///login response {"key":"1cbc9c0e6763041f9825971f332cf4517dd7413d"}
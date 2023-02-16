class RegisterRequestModel {
  RegisterRequestModel({required this.username, required this.password1, required this.password2, required String email});
  late final String username;
  late final String password1;
  late final String password2;
  late final String email;
  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password1 = json['password1'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final  _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['email'] = this.email;
    _data['password1'] = this.password1;
    _data['password2'] = this.password2;
    return _data;
  }
}

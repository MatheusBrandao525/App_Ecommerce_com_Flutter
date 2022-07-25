class UserModel {
  UserModel(
      {required this.email,
      required this.senha,
      required this.name,
      required String confirmPassword});
  String name = '';
  String email = '';
  String senha = '';

  String confirmPassword = '';

  Object? get uid => null;
}

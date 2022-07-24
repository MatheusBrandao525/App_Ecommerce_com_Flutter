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


// bugs a serem resolvidos!
/*

════════ Exception caught by gesture ═══════════════════════════════════════════
The following LateError was thrown while handling a gesture:
LateInitializationError: Field 'confirmPassword' has not been initialized.


════════ Exception caught by gesture ═══════════════════════════════════════════
LateInitializationError: Field 'confirmPassword' has not been initialized.
════════════════════════════════════════════════════════════════════════════════

════════ Exception caught by gesture ═══════════════════════════════════════════
LateInitializationError: Field 'confirmPassword' has not been initialized.

*/
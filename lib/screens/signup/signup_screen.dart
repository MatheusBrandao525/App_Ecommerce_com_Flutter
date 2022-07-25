import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manger.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  UserModel get user =>
      UserModel(email: '', name: '', senha: '', confirmPassword: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Cadastre-se'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 108, 122),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    enabled: !userManager.loading,
                    decoration:
                        const InputDecoration(hintText: 'Nome Completo'),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    validator: (name) {
                      if (name == null) return 'Preencha seu nome completo!';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (!emailValid(email!)) return 'E-mail inválido';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty || pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: confirmPassController,
                    enabled: !userManager.loading,
                    decoration:
                        const InputDecoration(hintText: 'Confirme sua senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass!.isEmpty || pass.length < 6) {
                        return 'Senha muito curta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: userManager.loading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                WidgetsFlutterBinding.ensureInitialized();
                                await Firebase.initializeApp();
                                userManager.signUp(
                                  user: UserModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    senha: passController.text,
                                    confirmPassword: confirmPassController.text,
                                  ),
                                  onFail: (e) {
                                    if (user.senha != user.confirmPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Falha ao criar conta: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  onSuccess: () {
                                    debugPrint('Sucesso!');
                                    // TODO: POP
                                  },
                                );
                              }
                            },
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Criar Conta',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

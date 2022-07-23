import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user.dart' as u;
import 'package:lojavirtual/models/user_manger.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 108, 122),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
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
                          return 'Senha invalida!';
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
                            : () {
                                if (formKey.currentState!.validate()) {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  await Firebase.initializeApp(); 
                                  userManager.sigIn(
                                      user: u.User(
                                        email: emailController.text,
                                        senha: passController.text,
                                      ),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Falha ao entrar: $e"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      onSuccess: () {
                                        // TODO: FECHAR A TELA DE LOGIN
                                      });
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Esqueci minha senha'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

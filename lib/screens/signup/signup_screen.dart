import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel get user => UserModel(email: '', name: '', senha: '');

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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome completo'),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Campo obrigatório!';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha seu nome completo!';
                    }
                    return null;
                  },
                  onSaved: (name) => user.name = name!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Campo obrigatório!';
                    } else if (!emailValid(email)) {
                      return 'Email inválido!';
                    }
                    return null;
                  },
                  onSaved: (email) => user.email = email!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Insira sua senha!';
                    } else if (pass.length <= 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.senha = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Repita sua senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Insira sua senha!';
                    } else if (pass.length <= 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => user.confirmPassword = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        if (user.senha != user.confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Senhas não coicidem"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                      }
                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:appdowill/config/preferences_keys.dart';
import 'package:appdowill/repo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/ContadorCubit/contador_cubit.dart';

class CarAdder extends StatelessWidget {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Adicione um Carro",
        textAlign: TextAlign.center,
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Equipe",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Numero",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () {
                    _doConfirm();
                    if (_nameController.toString().isNotEmpty &&
                        _numberController.toString().isNotEmpty) {
                      BlocProvider.of<ContadorCubit>(context).createCar(
                        int.parse(_numberController.text),
                        _nameController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Confirmar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doConfirm() {
    User newUser =
        User(nome: _nameController.text, numero: _numberController.text);
    print(newUser);
    _saveUser(newUser);
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.chave, json.encode(user.toJson()));
  }
}

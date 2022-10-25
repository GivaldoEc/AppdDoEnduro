import 'package:appdowill/bloc/cubit/contador_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    if (_nameController.toString().isNotEmpty &&
                        _numberController.toString().isNotEmpty) {
                      BlocProvider.of<ContadorCubit>(context).createCar(
                        int.parse(_numberController.toString()),
                        _nameController.toString(),
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
}

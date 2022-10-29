import 'package:appdowill/bloc/Connectivity/connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    ConnectivityCubit conCubit = BlocProvider.of<ConnectivityCubit>(context);
    return Drawer(
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                color: Colors.blueAccent,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    if (state is ConnectivityDisconnected) {
                      conCubit.mqttConnect();
                    } else if (state is ConnectivityConnected) {
                      conCubit.mqttDisconnect();
                    } else {
                      conCubit.mqttConnect();
                    }
                  },
                  icon: state is ConnectivityDisconnected
                      ? const SizedBox(
                          width: 120,
                          height: 120,
                          child: Icon(
                            Icons.wifi,
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox(
                          width: 120,
                          height: 120,
                          child: Icon(
                            Icons.wifi,
                            color: Colors.red,
                          ),
                        ),
                ),
              ),
              Container(
                color: Colors.blueGrey,
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          conCubit.publishTest();
                        },
                        icon: const Icon(Icons.waves)),
                    conCubit.flag
                        ? Icon(Icons.wifi)
                        : Icon(
                            Icons.wifi,
                            color: Colors.red,
                          )
                  ],
                ),
              ),
              Row(
                children: [],
              ),
            ],
          );
        },
      ),
    );
  }
}

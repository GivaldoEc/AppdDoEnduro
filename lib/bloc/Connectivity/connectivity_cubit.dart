import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../config/const/connectivity.dart';

part 'connectivity_state.dart';

MqttClient client = MqttServerClient.withPort(mqttBroker, '', 1883);

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial()) {
    mqttConnect();
  }

  bool flag = true;

  void mqttConnect() async {
    client.logging(on: true);

    emit(ConnectivityLoading());

    client.setProtocolV311();
    client.keepAlivePeriod = 60;
    client.connectTimeoutPeriod = 2000;
    client.port = mqttPort;

    client.websocketProtocols = MqttClientConstants.protocolsMultipleDefault;

    try {
      await client.connect(mqttUsername, mqttPassword);
    } on NoConnectionException catch (_) {
      client.disconnect();
    } on SocketException catch (_) {
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      emit(ConnectivityConnected());
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  // void subTest() {
  //   client.subscribe(mqtPubTopic, MqttQos.atMostOnce);
  //   flag = !flag;
  //   emit(ConnectivityConnected());
  // }

  // void publishTest() {
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString("Ola, raspchan!");
  //   client.publishMessage(mqtPubTopic, MqttQos.atLeastOnce, builder.payload!);
  // }

  void mqttDisconnect() {
    client.disconnect();
    emit(ConnectivityDisconnected());
  }
}

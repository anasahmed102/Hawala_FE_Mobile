import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:hawala/alerts/toast/failed_toast.dart';
import 'package:hawala/alerts/toast/success_toast.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';



@Named.from(ConnectionService)
@LazySingleton()
class ConnectionService with ChangeNotifier {
  // static final ConnectionService _singleton = ConnectionService._();
  // static ConnectionService get instance => _singleton;
  // ConnectionService._();
  bool isConnected = true;
  //check if mobile contains gms google mobile services
  bool isGMS = true;
  //check  internet connection
  Future<bool> checkIsConnected() async {
    await Future.delayed(const Duration(seconds: 1));
    // isConnected = await sl<ConnectionChecker>().isConnected;
    isConnected = await getItClient.get<ConnectionChecker>().isConnected;

    _showFlashBar(isConnected);
    logger("isConnected $isConnected");
    notifyListeners();
    return isConnected;
  }

  bool? _lastConnectionState;
  _showFlashBar(bool connected) {
    if (connected == _lastConnectionState) {
      return;
    }
    _lastConnectionState = connected;
    if (!connected) {
      showFailedFlashBar("internetConnectionWasLost");
    } else {
      // showSuccessFlashBar("internetConnectionWasBack"); 
    }
  }

  isGoogle() async {
    if (Platform.isIOS) {
      isGMS = true;
    } else {
      try {
        GooglePlayServicesAvailability availability =
            await GoogleApiAvailability.instance
                .checkGooglePlayServicesAvailability();
        logger("availability $availability");
        if ([
          GooglePlayServicesAvailability.serviceVersionUpdateRequired,
          GooglePlayServicesAvailability.success,
          GooglePlayServicesAvailability.serviceUpdating
        ].contains(availability)) {
          isGMS = true;
        } else {
          isGMS = false;
        }
      } catch (e, c) {
        logger("erron in check gogle $e");
        isGMS = false;
      }
    }

    notifyListeners();
  }

  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _streamSubscription;
  startListen() {
    isGoogle();
    checkIsConnected();
    _streamSubscription?.cancel();
    _streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      isConnected = event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi;
      logger("in listen $event ");
      checkIsConnected();
      notifyListeners();
    });
  }

  int current = 0;
  int total = 0;
  setCurrentAndTotal(current, total) {
    this.current = current;
    this.total = total;
    notifyListeners();
  }
}

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

@Named.from(ConnectionCheckerImpl)
@LazySingleton(as: ConnectionChecker)
class ConnectionCheckerImpl implements ConnectionChecker {
  Future<bool> _checkIsConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 30));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> get isConnected => _checkIsConnected();
}

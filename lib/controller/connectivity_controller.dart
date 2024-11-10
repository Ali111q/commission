import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  RxBool isConnected = true.obs;
  Timer? _timer;

  Future<void> checkConnection() async => await _pingGoogle();

  @override
  void onInit() {
    super.onInit();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();

    // Schedule a periodic check every 30 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkConnection();
    });
  }

  Future<void> _checkInitialConnection() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result.first != ConnectivityResult.none) {
      await _pingGoogle();
    } else {
      isConnected.value = false;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.first != ConnectivityResult.none) {
      _pingGoogle();
    } else {
      isConnected.value = false;
    }
  }

  Future<void> _pingGoogle() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      isConnected.value = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isConnected.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}

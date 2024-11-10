import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/connectivity_controller.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool extendBodyBehindAppBar;

  CustomScaffold({
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController =
        Get.find<ConnectivityController>();

    return Obx(() {
      return Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: appBar,
        body: Stack(
          children: [
            body ?? SizedBox.shrink(),
            if (!connectivityController.isConnected.value)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, size: 100, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        "No Internet Connection",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please check your network settings",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          connectivityController
                              .checkConnection(); // Recheck the connection
                        },
                        child: Text("Recheck"),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
      );
    });
  }
}

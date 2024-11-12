import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  //stream subscription to listen the live value
  late final StreamSubscription _streamSubscription;

  //track connections with observable
  var _isConnected = true.obs;

  //check dialog
  bool _isDialogOpen = false;

  //prevent initial online snak message
  bool _isOnline = false;

  //on Initial open of application
  @override
  void onInit() {
    super.onInit();
    _checkInternetConnectivity();

    //Listen
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_handleConnectionChange);
  }

  //checking internet connection status
  Future<void> _checkInternetConnectivity() async {
    // Connectivity plus return list of connected networks
    List<ConnectivityResult> connections =
        await _connectivity.checkConnectivity();

    //check connections with the available connected networks
    _handleConnectionChange(connections);

  }

  void _handleConnectionChange(List<ConnectivityResult> connections) {
    //.none represent non connected to any network
    if (connections.contains(ConnectivityResult.none)) {
      _isConnected.value = false;
      _isOnline = false;
      //show no internet dialog/alert
      showNoInternetDialog();
    } else {
      _isConnected.value = true;
      //close alert when back online
      _closeDialog();

      if (_isOnline) {
        Get.snackbar("Online", "Back Online",
            colorText: Colors.green[300],
            backgroundColor: Colors.green[50],
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  //alert
  void showNoInternetDialog() {
    if (_isDialogOpen) return; //prevent multiple dialog
    _isDialogOpen = true;
    _isOnline = true;
    Get.dialog(
            AlertDialog.adaptive(
              title: Text("Offline"),
              content: Text("You're Offline, Connect and try again"),
              actions: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        //retry functionality
                        _retryConnectiom();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          "Retry",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
            barrierDismissible: false)
        .then((_) {
      _isDialogOpen = false;
    });
  }

  Future<void> _retryConnectiom() async {
    List<ConnectivityResult> connections =
        await _connectivity.checkConnectivity();

    //checking
    if (!connections.contains(ConnectivityResult.none)) {
      _isConnected.value = true;
      Get.back();
    } else {
      Get.snackbar("Offline", "Check internet connection and try again",
          colorText: Colors.red[300],
          backgroundColor: Colors.red[50],
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _closeDialog() {
    if (_isDialogOpen) {
      Get.back();
      _isDialogOpen = false;
    }
  }

  @override
  void onClose() {
    //dispose stream
    _streamSubscription.cancel();
    super.onClose();
  }
}

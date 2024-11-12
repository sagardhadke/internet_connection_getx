import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_getx/connectivity_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Lottie.asset(
                "assets/no_internet.json",
                repeat: true,
                fit: BoxFit.fill,
                width: 350,
                height: 350,
              ),
            ),
            Text(
              "Oops, No Internet Connection",
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 15)),
                  "Make sure Wifi and Cellular data is turted \n on and then try again."),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  Get.find<ConnectivityController>().retryConnectiom();
                },
                child: Text(
                  "Try again",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

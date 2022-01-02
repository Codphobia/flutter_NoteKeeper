import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class SlpashScreen extends StatefulWidget {
  const SlpashScreen({Key? key}) : super(key: key);

  @override
  _SlpashScreenState createState() => _SlpashScreenState();
}

class _SlpashScreenState extends State<SlpashScreen> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration( seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
    } );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Center(
        child: SizedBox(height:400,width: 400,child: Lottie.asset('assets/notekeeper.json')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/constants/images.dart';
import 'package:notes_app/shared/network/local_network/preferences_helper.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/onBoading.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
       getStart();
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.secondary,
       body: SafeArea(child: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageUtility.logo),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 70,vertical: 40),
                child: LinearProgressIndicator(color: ColorUtility.main,semanticsLabel: "Loading",borderRadius: BorderRadius.circular(10),),
              )
            ],
          ),
        ),
       ),
    
    );
  }

  void getStart()async{
    await Future.delayed(const Duration(seconds: 3));
    if(!mounted)return;
    if(await PreferenceHelper.getIsOnBoardingSeen == true)
    {
   
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomeScreen()));
    }
    else
    {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  OnBoadringScreen()));

    }

  }
}
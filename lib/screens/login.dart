
import 'package:assignmentclimateapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../bloc/weather_bloc_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> signInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTimeUser', false);

      navigateToHomeScreen();

    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> registerUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTimeUser', false);

      navigateToHomeScreen();

    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if(snap.hasData) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) => WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
              child: const HomeScreen(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141318),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10,),
                Text(
                  'LOG IN ',
                  style: GoogleFonts.kufam(fontSize: 24, fontWeight: FontWeight.w600,color: Color(0xff13E9DC)),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: GoogleFonts.kufam(color: Colors.white.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff535353)),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff535353)),
                  ),
                  fillColor: Color(0xff141318),
                  filled: true,
                  prefixIcon: Icon(Icons.email,color: Colors.white,)
              ),
            ),
            SizedBox(height: 10),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff535353)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff535353)),
                ),
                hintStyle: GoogleFonts.kufam(color: Colors.white.withOpacity(0.5)),
                fillColor: Color(0xff141318),
                filled: true,
                prefixIcon: Icon(Icons.password,color: Colors.white,),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signInUser(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF13E9DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: Size(0.9 * MediaQuery.of(context).size.width, 48.0),
              ),
              child: Text(
                'Log In ',
                style: GoogleFonts.kufam(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                registerUser(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF13E9DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: Size(0.9 * MediaQuery.of(context).size.width, 48.0),
              ),
              child: Text(
                'Register ',
                style: GoogleFonts.kufam(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

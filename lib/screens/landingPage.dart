import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobcom/constants.dart';
import 'package:mobcom/screens/home.dart';
import 'package:mobcom/screens/login.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Scaffold(
                body:Center(
                  child: Text("Error: ${snapshot.error}"),
                )
            );
          }
          // connected to firebase
          if(snapshot.connectionState == ConnectionState.done){
            // stream builder checks the login state live
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamSnapshot){
                  //if streamSnapshot has error
                  if(streamSnapshot.hasError){
                    return Scaffold(
                        body:Center(
                          child: Text("Error: ${streamSnapshot.error}"),
                        ),
                    );
                  }
                  if(streamSnapshot.connectionState == ConnectionState.active){
                    //get user
                     Object? _user = streamSnapshot.data;
                     //if user == null, we are not logged in.
                    if(_user == null){
                      return LoginPage();
                    }else{
                      //the user is logged in head to home page
                      return HomePage();
                    }
                  }
                  //checking the auth state --loading
                  return Scaffold(
                    body: Center(
                      child: Text("checking Authentication",
                        style: Constants.regularHeading,
                      ),
                    ),
                  );
                }
            );
          }
          //connecting to firebase
          return Scaffold(
            body: Center(
              child: Text("initializing app",
                style: Constants.regularHeading,
              ),
            ),
          );
      }
    );
  }
}

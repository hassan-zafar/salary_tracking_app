import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/database/database.dart';
import 'package:salary_tracking_app/screens/auth/landing_page.dart';
import 'package:salary_tracking_app/widgets/bottom_bar.dart';

import '../main_screen.dart';

class UserState extends StatefulWidget {
  @override
  State<UserState> createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<User?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              print('userSnapshot.hasData ${userSnapshot.hasData}');
              uid = userSnapshot.data!.uid;
              DatabaseMethods()
                  .fetchUserInfoFromFirebase(uid: userSnapshot.data!.uid)
                  .then((value) {
                currentUser = value;
                print('The user is already logged in');
                return
                    //  BottomBarScreen();
                    currentUser != null ? const MainScreens() : null;
              });
              return const MainScreens();
            } else {
              print('The user didn\'t login yet');
              return
                  // IntroductionAuthScreen();
                  LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text('Error occured'),
            );
          } else {
            return const Center(
              child: Text('Error occured'),
            );
          }
        });
  }
}

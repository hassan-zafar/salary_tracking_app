// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:salary_tracking_app/consts/colors.dart';
import 'package:salary_tracking_app/database/database.dart';
import 'package:salary_tracking_app/main_screen.dart';
import 'package:salary_tracking_app/screens/auth/sign_up.dart';
import 'package:salary_tracking_app/services/authentication_service.dart';
import 'package:salary_tracking_app/services/global_method.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  List<String> images = [
    'assets/images/landingPage1.jpg',
    'assets/images/landingPage2.png',
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController!.reset();
              _animationController!.forward();
            }
          });
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  // Future<void> _googleSignIn() async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         String date = DateTime.now().toIso8601String();
  //         DateTime dateparse = DateTime.parse(date);
  //         String formattedDate =
  //             '${dateparse.day}-${dateparse.month}-${dateparse.year}';
  //         final UserCredential authResult = await _auth.signInWithCredential(
  //             GoogleAuthProvider.credential(
  //                 idToken: googleAuth.idToken,
  //                 accessToken: googleAuth.accessToken));
  //         DocumentSnapshot doc = await userRef.doc(authResult.user!.uid).get();
  //         print(doc.exists);
  //         if (doc.exists) {
  //           currentUser = AppUserModel.fromDocument(doc);
  //           print(currentUser);
  //           // final bool _isOkay = await UserAPI().addUser(currentUser!);

  //           // return true;
  //         } else {
  //           await FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(authResult.user!.uid)
  //               .set({
  //             'id': authResult.user!.uid,
  //             'name': authResult.user!.displayName,
  //             'email': authResult.user!.email,
  //             'phoneNumber': authResult.user!.phoneNumber,
  //             'imageUrl': authResult.user!.photoURL,
  //             'joinedAt': formattedDate,
  //             'createdAt': Timestamp.now(),
  //             "isAdmin": false,
  //             'subscriptionEndTIme': DateTime.now().toIso8601String()
  //           }).then((value) {
  //             final AppUserModel _appUser = AppUserModel(
  //                 id: authResult.user!.uid,
  //                 name: authResult.user!.displayName,
  //                 email: authResult.user!.email,
  //                 phoneNo: "",
  //                 androidNotificationToken: "",
  //                 password: "",
  //                 isAdmin: false,
  //                 subscriptionEndTIme: DateTime.now().toIso8601String(),
  //                 timestamp: formattedDate);
  //             currentUser = _appUser;

  //             UserLocalData().storeAppUserData(appUser: _appUser);
  //           });
  //         }
  //       } catch (error) {
  //         _globalMethods.authErrorHandle(error.toString(), context);
  //       }
  //     }
  //   }
  // }

  void _loginAnonymosly() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bool _login = await DatabaseMethods().loginAnonymosly();
      if (_login) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreens.routeName, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pop();
      }
      // await _auth.signInAnonymously();
    } catch (error) {
      _globalMethods.authErrorHandle(error.toString(), context);
      print('error occured ${error.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
       images[1],
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: FractionalOffset(_animation!.value, 0),
      ),
      Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:const [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Welcome to Wage me',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
            const  SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: ColorsConsts.backgroundColor),
                      ),
                    )),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified_user_outlined,
                          size: 18,
                        )
                      ],
                    )),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                          ),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                        Text(
                          'Sign up',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person_add_alt,
                          size: 18,
                        )
                      ],
                    )),
              ),
              SizedBox(width: 10),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children:const [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
              Text(
                'Or continue with',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlineButton(
                onPressed: () async {
                  final bool? _login =
                      await AuthenticationService().signinWithGoogle();
                  if (_login!) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainScreens(),
                    ));
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                shape: const StadiumBorder(),
                highlightedBorderColor: Colors.red.shade200,
                borderSide: const BorderSide(width: 2, color: Colors.red),
                child: const Text('Google'),
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : OutlineButton(
                      onPressed: () {
                        _loginAnonymosly();
                        // Navigator.pushNamed(context, BottomBarScreen.routeName);
                      },
                      shape: const StadiumBorder(),
                      highlightedBorderColor: Colors.deepPurple.shade200,
                      borderSide:
                          const BorderSide(width: 2, color: Colors.deepPurple),
                      child: const Text('Sign in as a guest'),
                    ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    ]));
  }
}

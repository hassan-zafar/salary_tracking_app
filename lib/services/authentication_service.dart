import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salary_tracking_app/consts/collections.dart';
import 'package:salary_tracking_app/database/database.dart';
import 'package:salary_tracking_app/models/users.dart';
import 'package:salary_tracking_app/widgets/custom_toast%20copy.dart';
import 'package:salary_tracking_app/widgets/custom_toast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // UserLocalData().logOut();
  }

  // Future logIn({
  //   required String email,
  //   required final String password,
  // }) async {
  //   print("here");
  //   try {
  //     // final UserCredential result =
  //     await _firebaseAuth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((value) {
  //       print(" auth service login: $value");
  //       print(" auth service login uid: ${value.user!.uid}");

  //       // return value.user!.uid;
  //       DatabaseMethods()
  //           .fetchUserInfoFromFirebase(uid: value.user!.uid)
  //           .then((value) => Get.off(() => LandingPage()));
  //     });
  //     // return result.user!.uid;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       errorToast(message: 'No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  Future deleteUser(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User user = _firebaseAuth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      UserCredential result =
          await user.reauthenticateWithCredential(credentials);
      userRef.doc(user.uid).delete();

      await result.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signinWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
        // clientId:
        //     '705884143448-evgaqsm4qmottc3o9mn2na1hqa0bk92s.apps.googleusercontent.com',
        signInOption: SignInOption.standard);

    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (googleAccount != null) {

      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      print(googleAuth.accessToken);
      if (googleAuth.accessToken != null 
      // && googleAuth.idToken != null
      ) {
        print('now here');

        try {
          String date = DateTime.now().toString();
          DateTime dateparse = DateTime.parse(date);
          String formattedDate =
              '${dateparse.day}-${dateparse.month}-${dateparse.year}';
          final UserCredential authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          DocumentSnapshot doc = await userRef.doc(authResult.user!.uid).get();
          print(doc.exists);
          if (doc.exists) {
            currentUser = AppUserModel.fromDocument(doc);
            // final bool _isOkay = await UserAPI().addUser(currentUser!);
            print(currentUser);
            return true;
          } else {
            final AppUserModel _appUser = AppUserModel(
              id: authResult.user!.uid,
              name: authResult.user!.displayName,
              email: authResult.user!.email,
              phoneNo: "",
              androidNotificationToken: "",
              imageUrl: authResult.user!.photoURL,
              password: "",
              subscriptionEndTIme: DateTime.now().toIso8601String(),
              isAdmin: false,
            );
            final bool _isOkay = await DatabaseMethods().addUser(_appUser);
            if (_isOkay) {
              currentUser = _appUser;
              return true;

              // UserLocalData().storeAppUserData(appUser: _appUser);
            } else {
              return false;
            }
          }
        } catch (error) {
          print(error.toString());
          CustomToast.errorToast(message: error.toString());
        }
      }
    }
    return false;
  }

  Future<UserCredential?> signUp({
    required final String password,
    required final String? name,
    required final String? joinedAt,
    required final String? imageUrl,
    required final Timestamp? createdAt,
    required final String email,
    required final int phoneNo,
    final bool? isAdmin,
  }) async {
    print("1st stop");

    try {
      final UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((Object obj) {
        errorToast(message: obj.toString());
      });
      final UserCredential user = result;
      assert(user != null);
      assert(await user.user!.getIdToken() != null);
      if (user != null) {
        await DatabaseMethods().addUserInfoToFirebase(
            password: password,
            name: name,
            createdAt: createdAt,
            email: email,
            joinedAt: joinedAt,
            userId: user.user!.uid,
            phoneNo: phoneNo,
            imageUrl: imageUrl,
            isAdmin: false);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      errorToast(message: "$e.message");
    }
  }
}

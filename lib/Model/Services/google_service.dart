import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/auth/gender.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';

import '../../Preference/preference.dart';
import '../apis/api_response.dart';
import '../response_model/social_login_res_model.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String? username;
String? userEmail;
String? userImage;

Future<String?> signInWithGoogle() async {
  List userUid = [];

  AuthViewModel socialLogInViewModel = Get.find();
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = authResult.user;

    username = user!.displayName;
    userEmail = user.email;
    userImage = user.photoURL;

    final User? currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser!.uid);
    log('USERSOCIALID :- ${firebaseAuth.currentUser!.uid}');
    await socialLogInViewModel.socialLoginViewModel(model: {
      'social_type': "Google ",
      "social_id": "${firebaseAuth.currentUser!.uid}",
      "device_id": PreferenceManager.getDeviceId(),
      "name": "$username",
      "email": "$userEmail",
    });
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();

    List data = querySnapshot.docs.map((doc) => doc.get('userUid')).toList();
    log('ALLUSERID ${data}');

    if (socialLogInViewModel.socialApiResponse.status == Status.COMPLETE) {
      SocialloginResponseModel socialResponse =
          socialLogInViewModel.socialApiResponse.data;
      if (socialResponse.status == "200") {
        PreferenceManager.setUserName(socialResponse.data!.username!);
        PreferenceManager.setUserId("${socialResponse.data!.userId}");
        PreferenceManager.setType('${socialResponse.data!.socialType}');
        PreferenceManager.setLogin(true);
        CommonSnackBar.commonSnackBar(message: '${socialResponse.message}');

        if (data.contains(PreferenceManager.getUserId())) {
          Get.offAll(
            () => BottomBar(),
          );
        } else {
          Get.offAll(
            () => GenderSelect(),
          );
        }
      }
    } else {
      CommonSnackBar.commonSnackBar(message: 'ERROR');
    }

    // CommonSnackBar.commonSnackBar(message: 'Success');
    return '$user';
  } catch (e) {
    CommonSnackBar.commonSnackBar(message: 'ERROR$e');
  }
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}

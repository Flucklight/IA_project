import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ia_project/model/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
late UserData userAcount;

Future<void> signInWithGoogle() async {
  final GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount!.authentication;

  final _credential = GoogleAuthProvider.credential(
    accessToken: _googleSignInAuthentication.accessToken,
    idToken: _googleSignInAuthentication.idToken,
  );

  final UserCredential _authResult = await _auth.signInWithCredential(_credential);
  final User? _user = _authResult.user;
  assert(!_user!.isAnonymous);

  await updateUserData(_user);
}

Future<void> updateUserData(User? user) async {
  DocumentReference userRef = _db.collection('users').doc(user!.uid);

  userRef.set({
    'uid': user.uid,
    'email': user.email,
    'lastSign': DateTime.now(),
    'photoURL': user.photoURL,
    'displayName': user.displayName,
  }, SetOptions(merge: true));

  userAcount = UserData.set(user, userRef);
}

void signOutGoogle() async {
  await _googleSignIn.signOut();
}
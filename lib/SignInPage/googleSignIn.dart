import 'package:BlogApp/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((_) {

      FirebaseAuth firebaseAuth=FirebaseAuth.instance;
      if(firebaseAuth.currentUser!=null){
      print(firebaseAuth.currentUser.email);
      Get.off(HomePage());
      }  else{

      }
    });
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

    body: _body(),
      
    );
  }

  Widget _body(){

    return Center(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Welcome to Blog App",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
          _googleSigninButton(),
          Divider(),
        ],
      ),
    );
  }

  Widget _googleSigninButton(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: MaterialButton(
              
                color: Colors.white,
                onPressed: (){
                _gSignIn();
          },
          
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/google.png",
                height: 40,
                width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Signin With Google')
              ],
            ),
          ),
      ),
    );
  }

  _gSignIn() async{

    GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );

  GoogleSignInAccount signInAccount= await _googleSignIn.signIn();
  GoogleSignInAuthentication authentication= 
  await signInAccount.authentication;

  AuthCredential credential=GoogleAuthProvider.credential(
    idToken: authentication.idToken,
    accessToken: authentication.accessToken
  );

    FirebaseAuth firebaseAuth= FirebaseAuth.instance;

    UserCredential userCredential=

    await firebaseAuth.signInWithCredential(credential);

    print(userCredential.user.email);

    Get.off(HomePage());

  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Classes/UserDetails.dart';
import 'package:laundry/Services/SharedPrefs.dart';


class AuthServices{
	final FirebaseAuth _auth = FirebaseAuth.instance;
	final Firestore _firestore = Firestore.instance;
	
	Future<void> logOutUser() async {
		try{
			_auth.signOut();
			SharedPrefs.setStringPreference("uid",null);
		}catch(e){
			try{
//				_googleSignIn.signOut();
				SharedPrefs.setStringPreference("uid",null);
			}catch(e1){
				print(e1);
			}
			print(e);
		}
	}
	
	
	Future<void> resetPassword(st,context) async{
		try {
			await _auth.sendPasswordResetEmail(email: st);
			Fluttertoast.showToast(
					msg: "A link has been sent your registered email Id ",
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 2,
					backgroundColor: Color(0xff666666),
					textColor: Colors.white,
					fontSize: 16.0);
			Navigator.pop(context);
		}on PlatformException catch(e){
			Fluttertoast.showToast(
					msg: e.message,
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 2,
					backgroundColor: Color(0xff666666),
					textColor: Colors.white,
					fontSize: 16.0);
		}
	}
	
	
	Future<UserBasic> loginUser(UserAuth authDetails) async {
		try {
			
			AuthResult user = await _auth.signInWithEmailAndPassword(
					email: authDetails.email, password: authDetails.password);
			SharedPrefs.setStringPreference("uid", user.user.uid);
			
			return UserBasic(
				email: user.user.email,
				uid: user.user.uid,
			);
		} on PlatformException catch (e) {
			throw PlatformException(
				message: "Wrong username / password",
				code: "403",
			);
		} catch (e) {
			return null;
		}
	}
	
	
	Future<User> registerUser(User user) async {
		try {
			AuthResult newUser = await _auth.createUserWithEmailAndPassword(
					email: user.email, password: user.password);
			await newUser.user.sendEmailVerification();
			_firestore.collection('Laundry User').document(newUser.user.uid).setData({
				"fullname": user.name,
				"phone": user.phoneNumber,
//				"phone": user.phoneNumber,
				"password": user.password,
//        "userType": user.userType,
//        "userConstitution": user.userConstitution,
//        "companyName": user.companyName,
//				"progress": 1,
			});
			
			AuthResult loginUser = await _auth.signInWithEmailAndPassword(
					email: user.email, password: user.password);
			SharedPrefs.setStringPreference("uid", loginUser.user.uid);
			
			return User(
				email: newUser.user.email,
				uid: newUser.user.uid,
				name: user.name,
			);
		} catch (e) {
			print(e);
			return null;
		}
	}
}
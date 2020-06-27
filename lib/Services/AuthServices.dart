import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
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
			UserBasic userBasic;
			AuthResult user = await _auth.signInWithEmailAndPassword(
					email: authDetails.email, password: authDetails.password);
			SharedPrefs.setStringPreference("uid", user.user.uid);
			print(user.user.uid);
			firebaseDatabase = FirebaseDatabase.instance;
			dbf= firebaseDatabase.reference().child("UserDetails");
			await dbf.once().then((DataSnapshot snapshot){
				if(snapshot != null ){
				Map<dynamic,dynamic> values = snapshot.value;
				print(values.keys);
				values.forEach((key, value) {
					if(key == user.user.uid) {
						userBasic = UserBasic(
							fullName: value["fullname"],
							email: user.user.email,
							uid: user.user.uid,
							userType: value["userType"],
							lat: value["workLat"],
							long: value["workLong"],
							phoneNumber: value["phone"],
						);
					}
				});}
			});
			print(userBasic.fullName);
			return userBasic;
		} on PlatformException catch (e) {
			throw PlatformException(
				message: "Wrong username / password",
				code: "403",
			);
		} catch (e) {
			print(e);
			print("here");
			return null;
		}
	}
	
	
	Future<User> registerUser(User user) async {
		try {
			AuthResult newUser = await _auth.createUserWithEmailAndPassword(
					email: user.email, password: user.password);
			await newUser.user.sendEmailVerification();
			
			await firebaseDatabase.reference().child("UserDetails").child(newUser.user.uid)
			.set({
				"fullname": user.name.toString(),
				"phone": user.phoneNumber.toString(),
				"email": user.email.toString(),
				"password": user.password.toString(),
				"userType": "Enter".toString(),
				"workLat": "0".toString(),
				"workLong": "0".toString(),
//        "userConstitution": user.userConstitution,
//        "companyName": user.companyName,
//				"progress": 1,
			});
			firebaseDatabase = FirebaseDatabase.instance;
			await firebaseDatabase.reference().child('Employee Record Distance').child(newUser.user.uid).child('jobId').set({
				"currentId": user.email.split("@")[0]+"000001",
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
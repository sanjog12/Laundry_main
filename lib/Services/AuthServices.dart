import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Classes/UserDetails.dart';
import 'package:laundry/Services/EmployeeServices.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/authentication/AuthenticateServices.dart';
import 'package:laundry/others/ToastOutputs.dart';


class AuthServices{
	final FirebaseAuth _auth = FirebaseAuth.instance;
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	Future<void> logOutUser(UserBasic userBasic) async {
		try {
			await SharedPrefs.setStringPreference('Password', null);
			await SharedPrefs.setStringPreference('Mobile', null);
			await EmployeeServices().logoutTimeRecord(userBasic);
		}catch(e){
			print(e);
		}
		toastMessage(message: "Logout Successfully");
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
		
		UserBasic userBasic;
		
		try{
			var user={
				"Password": authDetails.password,
				"MobileNo": authDetails.mobileNo,
			};
			
			Map<String, String> header = {
				'Content-type': 'application/json',
				'Accept': 'application/json'
			};
			
			var userJson = jsonEncode(user);
			print(userJson);
			
			final response = await http.post("http://208.109.15.34:8081/api/Employee/v1/LoginEmployee", body: userJson, headers: header);
			var data = await jsonDecode(response.body);
			print(data);
			if(data['Entity'] == null)
				throw('Wrong Credential');
			
			userBasic = UserBasic(
				name: data['Entity']['UName'].toString(),
				userID: data['Entity']['UserId'].toString(),
				designation: data['Entity']['Designation'].toString(),
				password: data['Entity']['Password'].toString(),
				isActive: data['Entity']['IsActive'].toString(),
				isDeleted: data['Entity']['IsDeleted'].toString(),
				storeId: data['Entity']['StoreId'].toString(),
				mobile: data['Entity']['Mobile'].toString(),
				startTime: data['Entity']['StartTime'].toString(),
				designationID: data['Entity']['Designation'].toString(), storeName: data['Entity']['StoreName'], hours: data['Entity']['NoOfHours'].toString(),
			);
			try {
				print("1");
				await Authenticate().validateUser(userBasic, authDetails);
				print("2");
				await SharedPrefs.setStringPreference('Mobile', userBasic.mobile);
				print("3");
				await SharedPrefs.setStringPreference('Password', authDetails.password);
				print("4");
				await EmployeeServices().loginTimeRecord(userBasic);
				print("5");
			}catch(e){
				print("error");
				print(e);
			}
			return userBasic;
		}catch(e){
			Fluttertoast.showToast(
					msg: e.toString(),
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Color(0xff666666),
					textColor: Colors.white,
					fontSize: 16.0);
			print(e);
		}
	}
	
	
	Future<User> registerUser(User user) async {
		final userRegister = {
			"UName":user.name,
			"Designation":user,
		};
	
	}
//		try {
//			AuthResult newUser = await _auth.createUserWithEmailAndPassword(
//					email: user.email, password: user.password);
//			await newUser.user.sendEmailVerification();
//
//			await firebaseDatabase.reference().child("UserDetails").child(newUser.user.uid)
//			.set({
//				"fullname": user.name.toString(),
//				"phone": user.phoneNumber.toString(),
//				"email": user.email.toString(),
//				"password": user.password.toString(),
//				"userType": "Enter".toString(),
//				"workLat": "0".toString(),
//				"workLong": "0".toString(),
////        "userConstitution": user.userConstitution,
////        "companyName": user.companyName,
////				"progress": 1,
//			});
//			firebaseDatabase = FirebaseDatabase.instance;
//			await firebaseDatabase.reference().child('Employee Record Distance').child(newUser.user.uid).child('jobId').set({
//				"currentId": user.email.split("@")[0]+"000001",
//			});
//
//			AuthResult loginUser = await _auth.signInWithEmailAndPassword(
//					email: user.email, password: user.password);
//			SharedPrefs.setStringPreference("uid", loginUser.user.uid);
//
//			return User(
//				email: newUser.user.email,
//				uid: newUser.user.uid,
//				name: user.name,
//			);
//		} catch (e) {
//			print(e);
//			return null;
//		}
//	}
}
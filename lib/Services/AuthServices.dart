import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/EmployeeServices.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/authentication/AuthenticateServices.dart';

class AuthServices{
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	bool logout = true;
	
	Future<bool> logOutUser(UserBasic userBasic, BuildContext context) async {
		try {
			await showDialog(
					context: context,
				builder: (context){
						return AlertDialog(
							title: Text("Alert"),
							content: Text("Are you sure you want to log out"),
							actions: [
								FlatButton(
									child: Text("Yes"),
									onPressed: (){
										Navigator.pop(context);
										logout = true;
									},
								),
								
								FlatButton(
									child: Text("No"),
									onPressed: (){
										Navigator.pop(context);
										logout = false;
									},
								)
							],
						);
				}
			);
			if(!logout) {
				throw(" ");
			}
			
			await SharedPrefs.setStringPreference('Password', null);
			await SharedPrefs.setStringPreference('Mobile', null);
			await EmployeeServices().logoutTimeRecord(userBasic);
			return true;
		}catch(e){
			print(e);
			return false;
		}
	}
	
	
	
	Future<UserBasic> loginUser(UserAuth authDetails, BuildContext context) async {
		
		UserBasic userBasic;
		bool login = true;
		
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
				endTime: data['Entity']['EndTime'].toString(),
				designationID: data['Entity']['Designation'].toString(), storeName: data['Entity']['StoreName'], hours: data['Entity']['NoOfHours'].toString(),
			);
			
			// if(userBasic.designation == "DeliveryBoy")
			// if(!(DateFormat("HH:mm").parse(DateFormat("HH:mm").format(DateTime.now())).isAfter(DateFormat("HH:mm").parse(userBasic.startTime).add(Duration(minutes: 30)))
			// && DateFormat("jm").parse(DateFormat("jm").format(DateTime.now())).isBefore(DateFormat("jm").parse(userBasic.endTime).subtract(Duration(minutes: 30))))
			// ){
			// 	print("passed time");
			//   return await showDialog(
			// 		context: context,
			// 		builder: (context){
			// 			return AlertDialog(
			// 				title: Text("Not Allowed"),
			// 				content: Text("You can't login in right now "),
			// 				actions: <Widget>[
			// 					FlatButton(
			// 						onPressed: (){
			// 							login = false;
			// 							Navigator.pop(context);
			// 						},
			// 						child: Text("Ok"),
			// 					)
			// 				],
			// 			);
			// 		}
			// 	);
			// }
			//
			// if(!login){
			// 	toastMessage(message: "Not Allowed right now");
			// 	throw(" ");
			// }
			
			try {
				await Authenticate().validateUser(userBasic, authDetails);
				await SharedPrefs.setStringPreference('Mobile', userBasic.mobile);
				await SharedPrefs.setStringPreference('Password', authDetails.password);
				await EmployeeServices().loginTimeRecord(userBasic);
			}catch(e){
				print("error");
				print(e);
			}
			return userBasic;
		}catch(e){
			debugPrint(e);
			Fluttertoast.showToast(
					msg: e.toString(),
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Color(0xff666666),
					textColor: Colors.white,
					fontSize: 16.0);
			return null;
		}
	}
}
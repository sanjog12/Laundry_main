import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import'package:http/http.dart' as http;
import 'package:laundry/Classes/UserBasic.dart';
import 'dart:convert';

class UserService{
	
	Future<UserBasic> getUserDetails(String mobile, String password) async {
		UserBasic userBasic;
		try {
			var user = {
				"Password": password,
				"MobileNo": mobile,
			};
			
			var userJson = jsonEncode(user);
			
			Map<String, String> header = {
				'Content-type': 'application/json',
				'Accept': 'application/json'
			};
			
			final response = await http.post(
					"http://208.109.15.34:8081/api/Employee/v1/LoginEmployee",
					body: userJson, headers: header);
			var data = await jsonDecode(response.body);
			print(data);
			if (data['Entity'] == null)
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
				designationID: data['Entity']['Designation'].toString(),
				storeName: data['Entity']['StoreName'],
				hours: data['Entity']['NoOfHours'].toString(),
			);
			return userBasic;
		} catch (e) {
			Fluttertoast.showToast(
					msg: "Something went wrong ...\nPlease Login again",
					toastLength: Toast.LENGTH_SHORT,
					gravity: ToastGravity.BOTTOM,
					timeInSecForIosWeb: 1,
					backgroundColor: Color(0xff666666),
					textColor: Colors.white,
					fontSize: 16.0);
			return null;
		}
	}
		
//		dbf= firebaseDatabase.reference().child("UserDetails");
//		await dbf.once().then((value){
//			Map<dynamic,dynamic> map = value.value;
//			map.forEach((key, value) {
//				if(key == firebaseUserId) {
//					print("h1"+value["phone"]);
//					userBasic = UserBasic(
//						fullName: value["fullname"],
//						email: value["email"],
//						uid: key,
//						userType: value["userType"],
//						lat: value["workLat"],
//						long: value["workLong"],
//						phoneNumber: value["phone"],
//					);
//				}
//			});
//		});

//		print("here "+userBasic.phoneNumber);
}
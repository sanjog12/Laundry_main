

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laundry/Classes/UserBasic.dart';

class FireStoreService{
	final Firestore _firestore = Firestore.instance;
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	Future<UserBasic> getUserDetails(firebaseUserId) async{
		UserBasic userBasic;
		dbf= firebaseDatabase.reference().child("UserDetails");
		await dbf.once().then((value){
			Map<dynamic,dynamic> map = value.value;
			map.forEach((key, value) {
				if(key == firebaseUserId) {
					print("h1"+value["phone"]);
					userBasic = UserBasic(
						fullName: value["fullname"],
						email: value["email"],
						uid: key,
						userType: value["userType"],
						lat: value["workLat"],
						long: value["workLong"],
						phoneNumber: value["phone"],
					);
				}
			});
		});
		
		print("here "+userBasic.phoneNumber);
		return userBasic;
	}
}
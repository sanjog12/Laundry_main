
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/LocalNotification.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:laundry/WaitScreen.dart';
import 'package:laundry/WorkerSection/Screen/HomePage.dart';
import 'package:laundry/authentication/AuthScreens/LoginScreen.dart';
import 'package:laundry/authentication/UserServices.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
	
	String mobile;
	String password;
	NotificationServices notificationServices = NotificationServices();
	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	UserService userService = UserService();
	
	
	
	@override
  void initState() {
    super.initState();
    getUserFirebaseId();
  }
  
  Future<String> getUserFirebaseId() async{
		String m = await SharedPrefs.getStringPreference('Mobile');
		String p = await SharedPrefs.getStringPreference('Password');
		this.setState((){
			mobile = m;
			password = p;
		});
		return m;
  }
	
  @override
  Widget build(BuildContext context) {
    return mobile==null
		    ?Login()
		    :StreamBuilder<UserBasic>(
	        stream: userService.getUserDetails(mobile, password).asStream(),
	        builder: (BuildContext context, snapshot){
	    	    if(snapshot.hasData){
	    	    	print(snapshot.data.mobile);
			        return HomePage(userBasic: snapshot.data);
		        }
	    	    else{
	    	    	return WaitScreen();
		        }
	        },
    );
  }
}

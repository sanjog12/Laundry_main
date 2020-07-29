import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/SharedPrefs.dart';
import 'package:laundry/authentication/AuthScreens/Login.dart';
import 'package:laundry/authentication/FirebaseStore.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
	
	String mobile;
	String password;
	
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
		        }
		        return HomePage(userBasic: snapshot.data);
	        },
    );
  }
}

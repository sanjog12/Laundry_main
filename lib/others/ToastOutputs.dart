import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


toastMessage({String message}){
	return Fluttertoast.showToast(
			msg: message,
			toastLength: Toast.LENGTH_SHORT,
			gravity: ToastGravity.BOTTOM,
			timeInSecForIosWeb: 1,
			backgroundColor: Color(0xff666666),
			textColor: Colors.white,
			fontSize: 16.0);
}
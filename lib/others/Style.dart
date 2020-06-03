import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration buildCustomInput({String hintText}){
	return InputDecoration(
			fillColor: Colors.white70,
			contentPadding: EdgeInsets.symmetric(
				vertical: 0.0,
				horizontal:16,
			),
			hintText: hintText,
			focusColor: Colors.white,
			hoverColor: Colors.white,
			border:OutlineInputBorder(
				borderSide:BorderSide(
					color: Colors.white,
					width:0,
					style:BorderStyle.solid,
				),
				borderRadius: BorderRadius.circular(8.0),
			),
			filled: true
	);
}
/*
   The layout of page which will appear after the worker will open the job 
which is specified in the work card in the work section . 
 */

import 'package:flutter/material.dart';
import 'package:laundry/Test/test1.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';

Future<bool> work_description(context,name , address){
	
	return showDialog(
			context: context,
			builder: (BuildContext context){
				return SimpleDialog(
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(10)
					),
					title: Text(name),
					titlePadding: EdgeInsets.only(left: 20),
					backgroundColor: Colors.lightBlueAccent,
					children: <Widget>[
						Padding(
							padding: EdgeInsets.only(top: 30),
						  child: Container(
						  	height: 300,
						  	width: 100,
						  	decoration: BoxDecoration(
						  		color: Colors.white,
						  	),
						  ),
						),
						
						Padding(
						  padding: EdgeInsets.only(left: 20, right: 60),
						  child: RaisedButton(
						  	onPressed: (){
						  		polyline().start_record();
						  		get_navigation();
						  	},
						  ),
						)
					],
				);
	}
	);
}

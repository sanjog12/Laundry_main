import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserDetails.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/screen_shot.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';



class DuringNavigation extends StatefulWidget {

	final UserAuth userAuth;
	final String docName ;
	final CreatePolyline object;
	DuringNavigation({this.userAuth, this.object , this.docName , Key key}):super(key : key);

	@override
	_DuringNavigationState createState() => _DuringNavigationState();
}

class _DuringNavigationState extends State<DuringNavigation> {
	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.blueGrey[700],
				elevation: 8,
				title: Text(
					"JOB",
					style: TextStyle(
						fontWeight: FontWeight.bold,
						fontFamily: "OpenSans",
						letterSpacing: 1.0,
					),
				),
				centerTitle: true,
				actions: <Widget>[
					IconButton(
						icon: Icon(
							Icons.notifications,
							color: Colors.blue[100],
						),
						onPressed: () {},
					),
				],
			),
			
			
			body: Stack(
			  children:<Widget>[
			  	Container(
					    height: size.height,
					    width: size.width,
					    child: Image.asset('images/12.jpg',
						    colorBlendMode: BlendMode.saturation,
						    fit: BoxFit.fill,
						    height: double.infinity,
						    width: double.infinity,
					    ),
				    ),
			  	
			  	
			  	Container(
			  	padding:EdgeInsets.all(40),
//			    	decoration: BoxDecoration(
//			    			border: Border.all(
//			    				width: 3.0,
//			    				color: Color.fromRGBO(88, 89, 91, 1),
//			    			),
//			    			borderRadius: BorderRadius.all(
//			    					Radius.circular(20.0)
//			    			)
//			    	),
			  	child: Column(
			  		crossAxisAlignment: CrossAxisAlignment.stretch,
			  		children: <Widget>[
			  			Center(child: Icon(Icons.work,size: 90,color: Color.fromRGBO(88, 89, 91, 1),),),
			  			
			  			SizedBox(height: 15,),
			  			
			  			Row(
			  				children: <Widget>[
			  				Text("DISTANCE TRAVELLED: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),
									    fontWeight: FontWeight.w700,
									    fontSize: 15.0),),
			  				Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
			  			],),
			  			
//				  					SizedBox(height: 15,),
//
//				  					Row(children: <Widget>[
//				  						Text("TIME TAKEN: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
//				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
//				  					],),
//
//				  					SizedBox(height: 15,),
//
//				  					Row(children: <Widget>[
//				  						Text("JOB STATUS: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
//				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
//				  					],),
//
//				  					SizedBox(height: 15,),
//
//				  					Row(children: <Widget>[
//				  						Text("DESTINATION: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
//				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
//				  					],),
//
				  					SizedBox(height: 40,),
			  			
			  			Center(
			  				child: Container(
			  					child: RaisedButton(
			  						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
			  						color: Colors.blueGrey[700],
			  						child: Text("END NAVIGATION",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue[100]),),
			  						onPressed: (){
			  							print("Navigating to screen shot page");
			  							Navigator.of(context).pop();
			  							Navigator.push(context,
			  									MaterialPageRoute(builder: (context) => ScreenShot(
			  										object: widget.object,
			  										docName: widget.docName,
			  										userAuth: widget.userAuth,
			  									)));
			  						},
			  					),
			  				),
			  			),
			  		],
			  	),
			  ),
			  ],
			),
		);
	}
}

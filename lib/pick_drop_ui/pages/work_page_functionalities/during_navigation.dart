import 'package:flutter/material.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/screen_shot.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';



class DuringNavigation extends StatefulWidget {

	final String docName ;
	final CreatePolyline object;
	DuringNavigation(this.object , this.docName , {Key key}):super(key : key);

	@override
	_DuringNavigationState createState() => _DuringNavigationState();
}

class _DuringNavigationState extends State<DuringNavigation> {
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Colors.white,
			child: Scaffold(
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
				body: Container(
					decoration: BoxDecoration(
							image: DecorationImage(image:  AssetImage("images/12.jpg"),fit: BoxFit.fill)
					),
					child: Row(
						children: <Widget>[

							Center(
								child: Padding(
									padding:EdgeInsets.only(top: 20, left: 45),
									child: Container(
										child: Container(
											height: 450,
											width: 250,
											margin: EdgeInsets.all(10.0),
											padding: EdgeInsets.all(15.0),
											decoration: BoxDecoration(
													border: Border.all(
														width: 3.0,
														color: Color.fromRGBO(88, 89, 91, 1),
													),
													borderRadius: BorderRadius.all(
															Radius.circular(5.0)
													)
											),
											child: Column(
												children: <Widget>[
													Center(child: Icon(Icons.work,size: 90,color: Color.fromRGBO(88, 89, 91, 1),),),
													Padding(padding: EdgeInsets.all(24.0)),
													Row(children: <Widget>[
														new Text("DISTANCE TRAVELLED: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
														new Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
													],),
													Padding(padding: EdgeInsets.all(15.0)),
													Row(children: <Widget>[
														new Text("TIME TAKEN: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
														new Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
													],),
													Padding(padding: EdgeInsets.all(15.0)),
													Row(children: <Widget>[
														new Text("JOB STATUS: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
														new Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
													],),
													Padding(padding: EdgeInsets.all(15.0)),
													Row(children: <Widget>[
														new Text("DESTINATION: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
														new Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
													],),
													Padding(padding: EdgeInsets.only(top: 15.0,bottom: 25)),
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
																			MaterialPageRoute(builder: (context) => ScreenShot(widget.object, widget.docName)));
																},
															),
														),
													),

												],
											),
										),
									),
								),


							),
						],
					),
				),
			),
		);
	}
}

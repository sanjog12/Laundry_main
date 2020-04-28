/*
   The layout of page which will appear after the worker will open the job 
which is specified in the work card in the work section . 
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/during_navigation.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';
import 'package:flutter/rendering.dart';

Future<bool> work_description(context,name , address){

	return showDialog(
			context: context,
			builder: (BuildContext context){



				return Mappage();

}
	);
}
class Mappage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapPageState();
  }

}
class _MapPageState extends State<Mappage>{
	Completer<GoogleMapController> _controller = Completer();
	static final CameraPosition _intial = CameraPosition(target: LatLng(28.640884,77.126071), zoom: 19);
	 List<Marker> markers = [];
	 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.add(Marker(
			markerId: MarkerId("Sanjog House"),
			draggable: false,
			onTap: (){
				print("Tapped");
			},
			position: LatLng(28.640884,77.126071)
		));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
			shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(10)
			),
			title: Padding(padding:EdgeInsets.all(10.0),child: Text("JOB ASSIGNED",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)),
			titlePadding: EdgeInsets.only(left: 20),
			backgroundColor: Colors.lightBlueAccent,
			children: <Widget>[
				Padding(
					padding: EdgeInsets.only(top: 30),
					child: Container(
						height: 300,
						width: 200,
						child: Stack(
							children: <Widget>[
								Center(
									child: Container(
										child: GoogleMap(initialCameraPosition: _intial,markers: Set.from(markers),
										mapType: MapType.normal,onMapCreated: (GoogleMapController controller){
											_controller.complete(controller);
											},)
									),
								),

							],
						),
						decoration: BoxDecoration(
							color: Colors.white,
						),
					),
				),

				Padding(
					padding: EdgeInsets.only(left: 20, right: 60),
					child: RaisedButton(
						child: new Text("NAVIGATE",textAlign: TextAlign.center,),
						onPressed: (){
							polyline object = polyline();
							object.start_record();
							get_navigation();
							Navigator.push(context,
									MaterialPageRoute(builder: (context)=>during_navigation(object))
							);
						},
					),
				)
			],
		);
  }

}


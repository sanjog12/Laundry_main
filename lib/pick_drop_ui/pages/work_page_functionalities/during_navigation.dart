
import 'dart:async';
import 'screen_shot.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';
import 'package:location/location.dart';



class DuringNavigation extends StatefulWidget {

	final UserAuth userAuth;
	final String docName ;
	final CreatePolyline object;
	final Job job;
	DuringNavigation({this.userAuth, this.object, this.docName, this.job, Key key}):super(key : key);

	@override
	_DuringNavigationState createState() => _DuringNavigationState();
}

class _DuringNavigationState extends State<DuringNavigation> {
	
	GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: 'AIzaSyA93lHM_TGSFAFktTinj7YYy4OlA8UM4Qc');
	Location location =Location();
	LatLng currentLocation;
	LatLng previousLocation;
	List<LatLng> routeCoords;
	Completer<GoogleMapController> _controller = Completer();
	GoogleMapController _controller1;
	Set<Polyline> polyline ={};
	FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	DatabaseReference dbf;
	
	Future<List<LatLng>> getPolyline() async{
		print(widget.job.lat + " " + widget.job.long);
		print(currentLocation);
		try{
		await googleMapPolyline.getCoordinatesWithLocation(
				origin: currentLocation,
				destination: LatLng(double.parse(widget.job.lat) , double.parse(widget.job.long)),
				mode: RouteMode.driving,
		).then((value){
			routeCoords = value;
		});}catch(e){
			print(e.toString());
		}
		print("printing");
		print(routeCoords.first);
		return routeCoords;
	}
	
	@override
  void initState() {
    super.initState();
    location.getLocation().then((value){
    	previousLocation = currentLocation;
    	currentLocation = LatLng(value.latitude,value.longitude);
    }).whenComplete(() async{
	    await getPolyline().then((value){
		    setState(() {
			    polyline.add(
					    Polyline(
						    polylineId: PolylineId('route1'),
						    visible: true,
						    points: value,
						    width: 4,
						    color: Colors.red,
						    startCap: Cap.roundCap,
						    endCap: Cap.buttCap,
					    )
			    );
		    });
	    });
    });
  }
  
  void updateCamera() async{
		final GoogleMapController controller = await _controller.future;
		controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation,zoom: 17)));
  }
	
  @override
  Widget build(BuildContext context) {
	  
	  location.onLocationChanged.listen((event) {
	  	print("inside");
		  setState(() {
			  currentLocation = LatLng(event.latitude,event.longitude);
		  });
		  updateCamera();
	  });
	  
    return Stack(
      children : <Widget>[
      	
      	Align(
		      alignment: Alignment.bottomCenter,
      	  child: Container(
		      padding: EdgeInsets.all(10),
		      child: FlatButton(
			      child: Text("Reached Destination"),
			      onPressed: () {
				      Navigator.of(context).pop();
			  							Navigator.push(context,
			  									MaterialPageRoute(builder: (context) => ScreenShot(
			  										object: widget.object,
			  										docName: widget.docName,
			  										userAuth: widget.userAuth,
			  									)));
			      }
		      ),
	      ),
      	),
      	
      	Container(
	    child: GoogleMap(
		    initialCameraPosition: CameraPosition(target: currentLocation != null?currentLocation:LatLng(0,0),zoom: 17),
		    polylines: polyline,
		    compassEnabled: true,
		    trafficEnabled: true,
		    myLocationEnabled: true,
		    mapType: MapType.normal,
		    onMapCreated: (GoogleMapController controller) async{
		    	_controller.complete(controller);
		    	controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation != null?currentLocation:LatLng(0,0),zoom: 17)));
		    	_controller1 = controller;
		    },
	    ),
      ),
  ],
    );
  }
	
	
	
	
//	@override
//	Widget build(BuildContext context) {
//		final size = MediaQuery.of(context).size;
//		return Scaffold(
//			appBar: AppBar(
//				backgroundColor: Colors.blueGrey[700],
//				elevation: 8,
//				title: Text(
//					"JOB",
//					style: TextStyle(
//						fontWeight: FontWeight.bold,
//						fontFamily: "OpenSans",
//						letterSpacing: 1.0,
//					),
//				),
//				centerTitle: true,
//				actions: <Widget>[
//					IconButton(
//						icon: Icon(
//							Icons.notifications,
//							color: Colors.blue[100],
//						),
//						onPressed: () {},
//					),
//				],
//			),
//			
//			
//			body: Stack(
//			  children:<Widget>[
//			  	Container(
//					    height: size.height,
//					    width: size.width,
//					    child: Image.asset('images/12.jpg',
//						    colorBlendMode: BlendMode.saturation,
//						    fit: BoxFit.fill,
//						    height: double.infinity,
//						    width: double.infinity,
//					    ),
//				    ),
//			  	
//			  	
//			  	Container(
//			  	padding:EdgeInsets.all(40),
////			    	decoration: BoxDecoration(
////			    			border: Border.all(
////			    				width: 3.0,
////			    				color: Color.fromRGBO(88, 89, 91, 1),
////			    			),
////			    			borderRadius: BorderRadius.all(
////			    					Radius.circular(20.0)
////			    			)
////			    	),
//			  	child: Column(
//			  		crossAxisAlignment: CrossAxisAlignment.stretch,
//			  		children: <Widget>[
//			  			Center(child: Icon(Icons.work,size: 90,color: Color.fromRGBO(88, 89, 91, 1),),),
//			  			
//			  			SizedBox(height: 15,),
//			  			
//			  			Row(
//			  				children: <Widget>[
//			  				Text("DISTANCE TRAVELLED: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),
//									    fontWeight: FontWeight.w700,
//									    fontSize: 15.0),),
//			  				Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
//			  			],),
//			  			
////				  					SizedBox(height: 15,),
////
////				  					Row(children: <Widget>[
////				  						Text("TIME TAKEN: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
////				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
////				  					],),
////
////				  					SizedBox(height: 15,),
////
////				  					Row(children: <Widget>[
////				  						Text("JOB STATUS: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
////				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
////				  					],),
////
////				  					SizedBox(height: 15,),
////
////				  					Row(children: <Widget>[
////				  						Text("DESTINATION: ",style: TextStyle(color: Color.fromRGBO(88, 89, 91, 1),fontWeight: FontWeight.w700,fontSize: 20.0),),
////				  						Text("__..__",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.0),),
////				  					],),
////
//				  					SizedBox(height: 40,),
//			  			
//			  			Center(
//			  				child: Container(
//			  					child: RaisedButton(
//			  						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//			  						color: Colors.blueGrey[700],
//			  						child: Text("END NAVIGATION",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue[100]),),
//			  						onPressed: (){
//			  							print("Navigating to screen shot page");
//			  							Navigator.of(context).pop();
//			  							Navigator.push(context,
//			  									MaterialPageRoute(builder: (context) => ScreenShot(
//			  										object: widget.object,
//			  										docName: widget.docName,
//			  										userAuth: widget.userAuth,
//			  									)));
//			  						},
//			  					),
//			  				),
//			  			),
//			  		],
//			  	),
//			  ),
//			  ],
//			),
//		);
//	}
}

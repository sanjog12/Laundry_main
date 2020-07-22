import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/TripDetails.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/pick_drop_ui/pages/customer_end_work/customer_end.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/Json_Road_Snapped.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';


class ScreenShot extends StatefulWidget {
	final UserBasic userBasic;
	final CreatePolyline object;
	final String docName;
	final Job job;
	GoogleMap map;
	ScreenShot({this.job, this.userBasic, this.object , this.docName ,Key key}): super(key: key);
  @override
  _ScreenShotState createState() => _ScreenShotState();
}




class _ScreenShotState extends State<ScreenShot> {
	
	List<LatLng> _points = [];
	List<LatLng> _temp = [];
	bool waiting = true;
	Size size;
	Completer<GoogleMapController> _controller = Completer();
	int _polylineIdCounter =1;
	Map<PolylineId,Polyline> polyLines = <PolylineId, Polyline>{};
	TripDetails tripDetails;
	
	
	@override
  void initState() {
    super.initState();
    widget.object.stopPolyline();
    print("FetchRoadSnapped function is called ");
    callFetchRoadSnapped().whenComplete(polylineIdGenerate);
    print("FetchRoadSnapped function is complited");
    print(widget.userBasic.mobile);
  }
  
  Future<void> callFetchRoadSnapped() async{
			_temp = await fetchRoadSnapped(widget.object.getrecordedlist(),widget.docName);
			print(_points);
			if(this.mounted) {
				setState(() {
					_points = _temp;
					waiting = false;
				});
			}
	}
  
	 LatLngBounds _latLngBounds(List<LatLng> list){
		print("About to check assert function in _latlongBoubds function");
		assert(list.isNotEmpty);
		print(list.length);
		
		print("assert is false exicuting further codes ");
		double x0,x1,y0,y1;
		for(LatLng latLng in list){
			if(x0==null){
				x0 = x1 =latLng.latitude;
				y0 = y1 =latLng.longitude;
			}else{
				if(latLng.latitude > x1) x1 = latLng.latitude;
				if(latLng.latitude < x0) x0 = latLng.latitude;
				if(latLng.longitude > y1) y1 = latLng.longitude;
				if(latLng.longitude < y0) y0 = latLng.longitude;
			}
		}
		print(x0 );
		return LatLngBounds(northeast: LatLng(x1,y1) , southwest: LatLng(x0 , y0));
	}
	
	
	Future<void> polylineIdGenerate() async{
		tripDetails = await distanceTimeNavigation(_points,widget.job);
		print("trip_details invoked ");
		final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
		_polylineIdCounter++;
		final PolylineId polylineId = PolylineId(polylineIdVal);
		
		final Polyline polyline =Polyline(
			jointType: JointType.mitered,
			startCap: Cap.roundCap,
			endCap: Cap.squareCap,
			geodesic: true,
			polylineId: polylineId,
			color: Colors.red,
			width: 5,
			points: _points,
			onTap: (){},
		);
		if(this.mounted) {
			setState(() {
				polyLines[polylineId] = polyline;
			});
		}
	}
	
	Future<void> uploadPic(png) async {
		String filename = widget.job.id +"k_${tripDetails.distance}" + "t_${tripDetails.time}";
		final StorageReference firebaseStorageRef =
				FirebaseStorage.instance.ref().child(widget.userBasic.mobile).child(filename);
		firebaseStorageRef.putData(png);
	}
	
  @override
  Widget build(BuildContext context) {
  	size = MediaQuery.of(context).size;
  	print("Map Container started");
  	print(_points);
    return waiting ?
		    Material(
			    type: MaterialType.transparency,
		      child: Container(
			    color: Colors.grey,
				    child: Column(
							    mainAxisAlignment: MainAxisAlignment.center,
				      children: <Widget>[
				        CircularProgressIndicator(
							    valueColor: AlwaysStoppedAnimation<Color>
								    (Colors.white),
				        ),
					      SizedBox(height: 20,),
					      Container(child: Text('Getting things Up....',style: TextStyle(
						      color: Colors.blueGrey[100],
						      fontSize: 20,
						      fontWeight: FontWeight.w500,
					      ),))
					      
				      ],
				    ),
		      ),
		    )
		    : AbsorbPointer(
		      child: Container(
			      height: size.height-200,
	          child: GoogleMap(
		        polylines: Set<Polyline>.of(polyLines.values),
		        initialCameraPosition: CameraPosition(target: _points.first),
		        mapType: MapType.normal,
		        zoomGesturesEnabled: true,
		        zoomControlsEnabled: true,
		        onMapCreated: (GoogleMapController controller) async {
		        	_controller.complete(controller);
			        await controller.animateCamera(CameraUpdate.newLatLngBounds(_latLngBounds(_points),4)).whenComplete(() async{
			        	await Future.delayed(Duration(seconds: 8));
			        	var png = await controller.takeSnapshot();
			        	await uploadPic(png).whenComplete(() {
			        		Navigator.push(context,
							        MaterialPageRoute(
									        builder: (context)=>CustomerEnd()
							        ),
					        );
			        	});
			        	await Firestore.instance.collection('Location Points').document().setData({
					        '${DateTime.now()}' : 'Screen Short Taken',
				        }, merge: true);
			        });
			        },
	          ),
		      ),
    );
  }
}
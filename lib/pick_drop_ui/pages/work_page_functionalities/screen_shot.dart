import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/pick_drop_ui/pages/work_page_functionalities/maps_functions.dart';


class screen_shot extends StatefulWidget {
	
	polyline object;
	screen_shot(this.object , {Key key}): super(key: key);
  @override
  _screen_shotState createState() => _screen_shotState();
}




class _screen_shotState extends State<screen_shot> {
	
	Size size;
	Completer<GoogleMapController> _controller = Completer();
	int _polylineIdCounter =1;
	Map<PolylineId,Polyline> polylines = <PolylineId, Polyline>{};
	
	
	
	
	LatLngBounds _latLngBounds(List<LatLng> list){
		/*
		    Function to return the boundary based on the points recorded in the list
		that bounds the google_map to a specified boundary and sets the zoom level
		 */
		
		print("About to check assert function in _latlongBoubds function");
		assert(list.isNotEmpty); /// If true then execution will happen normally
		/// if false then execution will be stopped here only
		
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
	
	
	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    trip_details();
    widget.object.stop_polyline();
  }
	
  
  
  
	void trip_details(){
		print("trip_details invoked ");
		/*
		Makes polyline connecting consecutive recorded points
		 */
		
		
		print(widget.object.getlist());
		final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
		_polylineIdCounter++;
		final PolylineId polylineId = PolylineId(polylineIdVal);
		
		final Polyline polyline =Polyline(
			jointType: JointType.round,
			geodesic: true,
			polylineId: polylineId,
			consumeTapEvents: true,
			color: Colors.lightBlueAccent,
			width: 5,
			points: widget.object.getlist(),
			onTap: (){},
		);
		setState(() {
			polylines[polylineId]=polyline;
		});
		
	}
	
  @override
  Widget build(BuildContext context) {
	
	  print(Set<Polyline>.of(polylines.values));
		
  	size = MediaQuery.of(context).size;
  	print("calling stop_polyline function ");
    return Container(
	    child: GoogleMap(
		    polylines: Set<Polyline>.of(polylines.values),
		    initialCameraPosition: CameraPosition(target: widget.object.getlist().first , zoom: 17),
		    mapType: MapType.normal,
		    zoomGesturesEnabled: true,
		    zoomControlsEnabled: true,
		    onMapCreated: (GoogleMapController controller){
			    _controller.complete(controller);
		    },
	    ),
    );
  
  }
}

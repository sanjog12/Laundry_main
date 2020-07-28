import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/Classes/Garment.dart';
import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:laundry/others/PDFBuilder.dart';
import 'package:laundry/others/PDFViewer.dart';
import 'package:path_provider/path_provider.dart';

bool listShow = false;
String _searchText = '';

List<GarmentInBasket> hashMap = [];

class CustomerEnd extends StatefulWidget {
  @override
  _CustomerEndState createState() => _CustomerEndState();
}

class _CustomerEndState extends State<CustomerEnd> {
	
	bool listener = true;
	TextEditingController _controller = TextEditingController();
	GarmentObject garmentObject;
	var response;
	var jsonResult ;
	int numberOfPieces=0;
	
	
	
	
	
	
	@override
  void initState() {
    super.initState();
    hashMap.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
	    response =  await http.get("http://208.109.15.34:8081/api/Garment/v1/GetGarments");
	    jsonResult = await jsonDecode(response.body);
	    await getGarmentDetails();
    });
    
  }
  
  Future<List<GarmentObject>> getGarmentDetails() async{
		print(jsonResult);
		List<GarmentObject> garmentList = [];
		
		for(var v in jsonResult){
			String garmentName, searchText, garmentCode, garmentPcs , subGarment;
			garmentName = v["GarmentName"].toString().toUpperCase();
			garmentCode = v["GarmentId"].toString();
			garmentPcs = v["GarmentPcs"].toString();
			subGarment = v["SubGarmentPcs"].toString();
			searchText = _searchText.toUpperCase();
			List<String> nameList = garmentName.split(searchText);
			if(nameList.length > 1){
				GarmentObject garmentObject =
						GarmentObject(
							garmentName: garmentName, garmentId: garmentCode, garmentPcs:  garmentPcs,
							subGarment: subGarment,
						);
				garmentList.add(garmentObject);
			}
		}
		return garmentList;
  }
	
	void onChange() {
		setState(() {
			_searchText = _controller.text;
			if (_searchText.length > 2) {
				listShow = true;
			} else {
				garmentObject = null;
				listShow = false;
			}
		});
	}
	
  @override
  Widget build(BuildContext context) {
		
	  if(listener){
		  _controller.addListener(onChange);}

	  else if (listener == false){
		  _controller.dispose();
		  _controller.removeListener(onChange);
	  }
	  
    return Scaffold(
	    appBar: AppBar(
		    iconTheme: IconThemeData(
				    color: Colors.blue[100]
		    ),
		    title: Text("Challan",style: TextStyle(
				    fontFamily: "OpenSans",
				    fontWeight: FontWeight.bold,
				    letterSpacing: 1.0,
				    color: Colors.blue[100]),),
		    centerTitle: true,
		    backgroundColor: Colors.blueGrey[700],
	    ),
	    
	    body: SingleChildScrollView(
	      child: Container(
		      decoration: BoxDecoration(
			      image: DecorationImage(
					      image: AssetImage("images/12.jpg"),
					      fit: BoxFit.fill
			      ),
		      ),
		      height: MediaQuery.of(context).size.height*0.90,
		      padding: EdgeInsets.all(20),
		      child: Column(
			      crossAxisAlignment: CrossAxisAlignment.stretch,
			      children: <Widget>[
			      	Text("Search for Garment"),
				      TextFormField(
					      controller: _controller,
					      autofocus: false,
				      ),
					      
				      listShow ?
				      Container(
					      height: 150,
					      child: FutureBuilder<List<GarmentObject>>(
						      future: getGarmentDetails(),
						      builder: (BuildContext context, AsyncSnapshot<List<GarmentObject>> snapshot) {
						      	if (snapshot.hasData) {
						      		print(snapshot.data.length);
						      		return Container(
									      color: Colors.white70,
									      alignment: Alignment.center,
									      child: ListView.builder(
										      itemCount: snapshot.data.length,
										      itemBuilder: (BuildContext context, int index) {
										      	return GestureDetector(
												      onTap: () {
												      	setState(() {
												      		listShow = false;
												      		_searchText = snapshot.data[index].garmentName;
												      		garmentObject =
																      GarmentObject(
																		      garmentName: snapshot.data[index].garmentName,
																		      garmentPcs: snapshot.data[index].garmentPcs,
																		      subGarment: snapshot.data[index].subGarment,
																		      garmentId: snapshot.data[index].garmentId
																      );
												      	});
												      	FocusScope.of(context).requestFocus(FocusNode());
												      	},
												      child: Container(
													      color: Colors.white70,
													      margin: EdgeInsets.all(5),
													      child: Text(
														      snapshot.data[index].garmentName,
														      style: TextStyle(color: Colors.black),
													      ),
												      ),
											      );
										      	},
									      ),
								      );
						      	} else
						      		return SizedBox();
						      	},
					      ),
				      )
						      : SizedBox(),
				      SizedBox(
					      height: 30.0,
				      ),
				      garmentObject != null?
				      Column(
					      crossAxisAlignment: CrossAxisAlignment.stretch,
					      children: <Widget>[
						      Container(
							      padding: EdgeInsets.all(10),
							      decoration: BoxDecoration(
								      border: Border.all(
									      width: 2,
									      color: Colors.grey
								      )
							      ),
						        child: Column(
							      crossAxisAlignment: CrossAxisAlignment.stretch,
							      children: <Widget>[
								      Text("Selected Garment"),
								      SizedBox(height: 5,),
								      Text(_searchText),
								      SizedBox(height: 25,),
							      	Text("Enter No. Pieces"),
								      SizedBox(height: 2,),
								      TextFormField(
									      onChanged: (value){
									      	numberOfPieces = int.parse(value);
									      	},
									      keyboardType: TextInputType.number,
									      inputFormatters: <TextInputFormatter>[
									      	WhitelistingTextInputFormatter.digitsOnly
									      ],
								      ),
								      SizedBox(height: 20,),
								      Container(
									      padding: EdgeInsets.symmetric(horizontal: 30),
									      child: FlatButton(
										      shape: RoundedRectangleBorder(
											      borderRadius: BorderRadius.circular(15),
										      ),
										      color:Colors.blueGrey[700],
										      child: Text("Add to Challan",style: TextStyle(
											      color: Colors.blue[100],
										      ),),
										      onPressed: (){
											      print(numberOfPieces);
											      if(numberOfPieces != 0 ){
												      hashMap.add(GarmentInBasket(
													      quantity: numberOfPieces,
													      garmentObject: garmentObject,
												      ));
											      }
											      setState(() {
												      numberOfPieces = 0;
												      _searchText ="";
												      garmentObject = null;
												      _controller.clear();
											      });},
									      ),
								      ),
							       ],
						        ),
						      ),
					      ],
				      ):Container(),
				      
				      Container(
					      padding: EdgeInsets.symmetric(horizontal: 20),
				        child: Column(
				          children: <Widget>[
				          	SizedBox(height: 40,),
				            FlatButton(
					            shape: RoundedRectangleBorder(
						            borderRadius: BorderRadius.circular(15),
					            ),
					            color:Colors.blueGrey[700],
					            child: Text("See added Cloths",style: TextStyle(
						            color: Colors.blue[100],
					            ),),
					            onPressed: (){
					            	getAddedClothsList(context);},
				            ),
					          SizedBox(height: 30,),
					          
					          FlatButton(
						          shape: RoundedRectangleBorder(
							          borderRadius: BorderRadius.circular(15),
						          ),
						          color:Colors.blueGrey[700],
						          child: Text("Final Challan", style: TextStyle(
							          color: Colors.blue[100],
						          ),),
						          onPressed: () async{
						          	writeInPdf(hashMap);
						          	await savePdf();
						          	Directory documentDirectory = await getApplicationDocumentsDirectory();
						          	String documentPath = documentDirectory.path;
						          	String filePath = "$documentPath/example.pdf";
						          	Navigator.push(context,
									          MaterialPageRoute(
											          builder: (context) => PdfProviderScreen(
												          path: filePath,))
							          );},
					          ),
				          ],
				        ),
				      ),
			      ],
		      ),
	      ),
	    ),
    );
  }
  
  getAddedClothsList(BuildContext context){
		return showDialog(
				context: context,
			builder: (BuildContext context){
					return AlertDialog(
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadiusDirectional.circular(10)
						),
						title: Text("Added Items"),
						content: Column(
							children: <Widget>[
								Divider(thickness: 1),
								SizedBox(height: 20),
								SingleChildScrollView(
								  child: Container(
								  	height: 500,
								    width: 300,
								    child: ListView.builder(
								    	shrinkWrap: true,
								    	itemCount: hashMap.length,
								    	itemBuilder:(BuildContext context, index){
								    		if(hashMap.length !=0) {
								    			return Container(
								    				child: ListTile(
								    					title: Text(hashMap[index].garmentObject.garmentName),
								    					leading: Text('${hashMap[index].quantity}'),
								  					    onTap: () async{
								    						bool t = await removeAddedItem(context);
								    						if(t) {
								    							setState(() {
								  								    hashMap.remove(hashMap[index]);
								  								    Navigator.pop(context);
								  								    getAddedClothsList(context);
								    							});
								  						    }
								  					    },
								    				),
								    			);
								    		}
								    		else{
								    			return Container(
								    				child: Text("No Item Added"),
								    			);
								    		}
								    	}
								    ),
								  ),
								),
								Align(
									alignment: Alignment.bottomCenter,
									child: Text("Tap to Remove item",style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
								)
							],),
					);
				});
	}
  
  removeAddedItem(BuildContext context) async{
		bool r ;
		await showDialog(
				context: context,
			builder: (BuildContext context){
				return AlertDialog(
					title: Text("Confirm"),
					content: Text("Are you sure want to remove this item?"),
					actions: <Widget>[
						FlatButton(
							child: Text("Remove"),
							onPressed: (){
								r = true;
								Navigator.pop(context);
							},
						),
						FlatButton(
							child: Text("Cancel"),
							onPressed: (){
								r = false;
								Navigator.pop(context);
							},
						)
					],
				);
			}
		);
		if(r){
			return true;
		}
		else{
			return false;
		}
  }
  
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/Classes/Garment.dart';
import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:laundry/Classes/Job.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Classes/WorkAvailable.dart';
import 'package:laundry/others/PDFBuilder.dart';
import 'package:laundry/others/PDFViewer.dart';
import 'package:path_provider/path_provider.dart';

bool listShow = false;
String _searchText = '';

List<GarmentInBasket> hashMap = [];

class CustomerEnd extends StatefulWidget {
	
	final Job job;
	final UserBasic userBasic;

  const CustomerEnd({Key key, this.job, this.userBasic}) : super(key: key);
	
	
  @override
  _CustomerEndState createState() => _CustomerEndState();
}

class _CustomerEndState extends State<CustomerEnd> {
	
	String challanNumber;
	bool listener = true;
	TextEditingController _controller = TextEditingController();
	GarmentObject garmentObject ;
	var response;
	var jsonResult ;
	int numberOfPieces=0;
	List<WorkAvailable> workSelected = [];
	List<WorkAvailable> works =[];
	bool laundry = false,laundryMix= false,mend=false,charak = false,dryClean = false;
	bool dye = false, express = false, reprocess = false, starch = false,stiching = false;
	bool streamPress = false, commercialWash = false;
	
	
	Future<void> sendDataToWeb(List<GarmentInBasket> list) async{
		try{
			Map<String,dynamic> json ={
				"PickDropJobId" : int.parse(widget.job.jobId),
				"CreatedBy":2,
				"LstMobileDetailChallanModel" : [
					for(var v in list){
							"GarmentId": int.parse(v.garmentObject.garmentId),
							"GarmentJobId": v.jobIdJson,
					}
				]
			};
			Map<String, String> header = {
				'Content-type': 'application/json',
				'Accept': 'application/json'
			};
			print(json);
			var v = jsonEncode(json);
			print(v);
			var response = await http.post("http://208.109.15.34:8081/api/Challan/v1/AddChallan",body: v, headers: header);
			var jsonResult = await jsonDecode(response.body);
			challanNumber = jsonResult["Entity"]["ChallanNo"];
			print(jsonResult["Entity"]["ChallanNo"]);
		}catch(e){
			print("error " +e.toString());
		}
	}
	
	Future<List<String>> workAvailableListFetch() async{
		try{
			List<String> temp ;
			http.Response response = await http.get("http://208.109.15.34:8081/api/GarmentJob/v1/GetAllGarmentJobs");
			jsonResult = jsonDecode(response.body);
			print(jsonResult);
			for(var v in jsonResult){
				works.add(WorkAvailable(nameOfWork: v['JobType'], codeOfWork: v['JobTypeID']));
				print(v["JobTypeID"]);
			}
			print(jsonResult);
			return temp;
		}catch(e){
			print("error");
			print(e.toString());
			return null;
		}
	}
	
	
	
	@override
  void initState() {
    super.initState();
    hashMap.clear();
    workAvailableListFetch();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
	    response =  await http.get("http://208.109.15.34:8081/api/Garment/v1/GetGarments");
	    jsonResult = await jsonDecode(response.body);
	    await getGarmentDetails();
    });
    
  }
  
  Future<List<GarmentObject>> getGarmentDetails() async{
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
	    
	    body: Container(
			      decoration: BoxDecoration(
				      image: DecorationImage(
						      image: AssetImage("images/12.jpg"),
						      fit: BoxFit.fill
				      ),
			      ),
			      height: MediaQuery.of(context).size.height*0.90,
			      padding: EdgeInsets.all(20),
			      child: ListView(
				      shrinkWrap: true,
//				      crossAxisAlignment: CrossAxisAlignment.stretch,
				      children: <Widget>[
				      	Text("Select garment name"),
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
										      shrinkWrap: true,
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
						      	}
						      	else
						      		return SizedBox();
						      	},
					      ),
				      ) : SizedBox(),
				      
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
									      width: 4,
									      color: Colors.grey
								      )
							      ),
						        child: Column(
							      crossAxisAlignment: CrossAxisAlignment.stretch,
							      children: <Widget>[
								      Text("Selected Garment :",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
								      SizedBox(height: 5,),
								      Text(_searchText,textAlign: TextAlign.center),
								      Divider(thickness: 4,color: Colors.grey,),
								      SizedBox(height: 25),
							      	Text("Enter No. Pieces"),
								      SizedBox(height: 2),
								      TextFormField(
									      decoration: InputDecoration(
										     
									      ),
									      onChanged: (value){
									      	numberOfPieces = int.parse(value);
									      	},
									      keyboardType: TextInputType.number,
									      inputFormatters: <TextInputFormatter>[
									      	WhitelistingTextInputFormatter.digitsOnly
									      ],
								      ),
								      SizedBox(height: 20),
                      
                      Wrap(
	                     children: <Widget>[
	                     	Wrap(
		                      crossAxisAlignment: WrapCrossAlignment.center,
		                      children: <Widget>[
		                      	Checkbox(
				                     value: laundry,
				                     onChanged: (bool value){
				                     	setState(() {
				                     	  laundry = value;
				                     	});
				                     	if(laundry)
				                     		workSelected.add(works.singleWhere((element) => element.nameOfWork == "Laundry"));
				                     	else
				                     		workSelected.removeWhere((element) => element.nameOfWork == "Laundry");
				                     },
			                      ),
			                      Text("Laundry"),
		                      ],
	                      ),
		                     
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: laundryMix,
					                     onChanged: (bool value){
						                     setState(() {
							                     laundryMix = value;
						                     });
						                     if(laundryMix)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Laundry Mix"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Laundry Mix");
					                     },
				                     ),
				                     Text("Laundry Mix"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: charak,
					                     onChanged: (bool value){
						                     setState(() {
							                     charak = value;
						                     });
						                     if(charak)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Charak"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Charak");
					                     },
				                     ),
				                     Text("Charak"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: dryClean,
					                     onChanged: (bool value){
						                     setState(() {
							                     dryClean = value;
						                     });
						                     if(dryClean)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Dry Clean"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Dry Clean");
					                     },
				                     ),
				                     Text("Dry Clean"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: dye,
					                     onChanged: (bool value){
						                     setState(() {
						                     	  dye = value;
						                     });
						                     if(dye)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Dye"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Dye");
					                     },
				                     ),
				                     Text("Dye"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: express,
					                     onChanged: (bool value){
						                     setState(() {
							                     express = value;
						                     });
						                     if(express)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Express"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Express");
					                     },
				                     ),
				                     Text("Express"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: mend,
					                     onChanged: (bool value){
						                     setState(() {
							                     mend = value;
						                     });
						                     if(mend)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Mend"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Mend");
					                     },
				                     ),
				                     Text("Reprocess"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: reprocess,
					                     onChanged: (bool value){
						                     setState(() {
							                     reprocess = value;
						                     });
						                     if(reprocess)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Reprocess"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Reprocess");
					                     },
				                     ),
				                     Text("Reprocess"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: starch,
					                     onChanged: (bool value){
						                     setState(() {
							                     starch = value;
						                     });
						                     if(starch)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "STARCH"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "STARCH");
					                     },
				                     ),
				                     Text("STARCH"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: stiching,
					                     onChanged: (bool value){
						                     setState(() {
							                     stiching = value;
						                     });
						                     if(stiching)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Stiching"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Stiching");
					                     },
				                     ),
				                     Text("Stiching"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: streamPress,
					                     onChanged: (bool value){
						                     setState(() {
							                     streamPress = value;
						                     });
						                     if(streamPress)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Stream Press"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Stream Press");
					                     },
				                     ),
				                     Text("Stream Press"),
			                     ],
		                     ),
		
		                     Wrap(
			                     crossAxisAlignment: WrapCrossAlignment.center,
			                     children: <Widget>[
				                     Checkbox(
					                     value: commercialWash,
					                     onChanged: (bool value){
						                     setState(() {
							                     commercialWash= value;
						                     });
						                     if(commercialWash)
							                     workSelected.add(works.singleWhere((element) => element.nameOfWork == "Commercial Wash"));
						                     else
							                     workSelected.removeWhere((element) => element.nameOfWork == "Commercial Wash");
					                     },
				                     ),
				                     Text("Commercial Wash"),
			                     ],
		                     ),
	                     ],
                      ),
								      
								      SizedBox(height: 25),
								      
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
										      	String temp = "",temp2 ="";
											      for(int v =0 ;v < workSelected.length ;v++){
												      temp = temp + workSelected[v].nameOfWork + ", ";
												      temp2 = temp2 + workSelected[v].codeOfWork.toString() + (v!=workSelected.length -1 ?",":"");
											      }
											      if(numberOfPieces != 0 ){
												      hashMap.add(GarmentInBasket(
													      quantity: numberOfPieces,
													      garmentObject: garmentObject,
													      workAvailable: workSelected,
													      nameOfWork: temp,
													      jobIdJson: temp2,
												      ));
											      }
											      setState(() {
											      	laundry = false;laundryMix= false;
											      	mend=false;charak = false;dryClean = false;
												      dye = false; express = false;
												      reprocess = false; starch = false;stiching = false;
												      streamPress = false; commercialWash = false;
											      	workSelected = [];
												      numberOfPieces = 0;
												      _searchText = "";
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
						          onPressed: () async {
							          await loadingWidget(context);
							          await sendDataToWeb(hashMap);
						          	await writeInPdf(hashMap,challanNumber);
						          	await savePdf(challanNumber);
						          	Directory documentDirectory = await getApplicationDocumentsDirectory();
						          	String documentPath = documentDirectory.path;
						          	String filePath = "$documentPath/$challanNumber.pdf";
						          	Navigator.pop(context);
						          	Navigator.pop(context);
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
								    		print("Check number " + hashMap[index].workAvailable.length.toString());
								    		if(hashMap.length !=0) {
								    			String temp = "";
								    			for(int v =0 ; v<hashMap[index].workAvailable.length ; v++){
								    				temp = temp + hashMap[index].workAvailable[v].nameOfWork + " |";
											    }
								    			return Container(
								    				child: ListTile(
								    					trailing: Text(hashMap[index].quantity.toString()),
								    					subtitle: Text(temp),
								    					title: Text('${hashMap[index].garmentObject.garmentName}'),
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
  
  loadingWidget(BuildContext context){
		return showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					shape: RoundedRectangleBorder(),
					content: CircularProgressIndicator(
						valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
					),
				);
			}
		);
  }
}

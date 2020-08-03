import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pf;
import 'package:path_provider/path_provider.dart';

final pdf = pf.Document();

writeInPdf(List<GarmentInBasket> temp){
	int totalGarment = 0;
	int i =1;
	
	var temp2 = [];
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Laundry';});
	var tempLaundry = [];
	tempLaundry.addAll(temp);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Laundry Mix';});
	var tempLaundryMix = [];
	tempLaundryMix.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Charak';});
	var tempCharak = [];
	tempCharak.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Dry Clean';});
	var tempDryClean = [];
	tempDryClean.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Dye';});
	var tempDye = [];
	tempDye.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Express';});
	var tempExpress = [];
	tempExpress.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Mend';});
	var tempMend = [];
	tempMend.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Reprocess';});
	var tempReprocess = [];
	tempReprocess.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Steam Press';});
	var tempStreamPress = [];
	tempStreamPress.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Stiching';});
	var tempStiching = [];
	tempStiching.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'STARCH';});
	var tempStarch = [];
	tempStarch.addAll(temp2);
	
	temp2.addAll(temp);
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Commercial Wash';});
	var tempCommercialWash = [];
	tempCommercialWash.addAll(temp2);
	print("L");
	
	for(var v in temp)
		totalGarment = totalGarment + v.quantity;
	
	print(temp.length);
	pdf.addPage(
		pf.MultiPage(
			pageFormat: PdfPageFormat.a4,
			margin: pf.EdgeInsets.all(20),
			build: (pf.Context context){
				return <pf.Widget> [
					pf.Align(
						alignment: pf.Alignment.center,
						child:pf.Text("Company",style: pf.TextStyle(fontWeight: pf.FontWeight.bold),textAlign: pf.TextAlign.center),
					),
					
					pf.Align(
						alignment: pf.Alignment.center,
						child: pf.Text("Address Line1,Address Line 2,Address Line 3"),
					),
					pf.Align(
						alignment: pf.Alignment.center,
						child: pf.Text("Contact Number : 123456789"),
					),
					pf.Align(
						alignment: pf.Alignment.center,
						child: pf.Text("website@website.com"),
					),
					
					pf.SizedBox(height: 10),
					pf.Text("Job Id: 1234567899",textAlign: pf.TextAlign.right),
					pf.SizedBox(height: 20),
					
					pf.Text("H.no,\nGali No.,\nTown,\nCity,\nPinCode",),
					
					pf.SizedBox(height: 40),
					
					
					pf.Header(
						text: "Laundry Work",
					),
					
					pf.Column(
						children: <pf.Widget>[
							pf.Container(
								padding: pf.EdgeInsets.symmetric(horizontal: 20),
								child: pf.Table.fromTextArray(
									headerStyle: pf.TextStyle(
										color: PdfColors.white,
										fontStyle: pf.FontStyle.normal,
									),
									
									headerDecoration: pf.BoxDecoration(
											color: PdfColors.black
									),
									
									columnWidths: {
										1:pf.FlexColumnWidth()
									},
									
									headers: ['S.No.','Name Of Garment', 'Quantity'],
									
									border: pf.TableBorder(
										width: 1.5,
									),
									
									data: <List<String>>[
										if(tempLaundry.length != 0)["","Laundry",""],
										if(tempLaundry.length != 0)
											for(var v in tempLaundry)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempLaundryMix.length != 0)["","Laundry Mix",""],
										if(tempLaundryMix.length != 0)
											for(var v in tempLaundryMix)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempStreamPress.length != 0)["","Stream Press",""],
										if(tempStreamPress.length != 0)
											for(var v in tempStreamPress)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempStiching.length != 0)["","Stiching",""],
										if(tempStiching.length != 0)
											for(var v in tempStiching)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempReprocess.length != 0)["","Reprocess",""],
										if(tempReprocess.length != 0)
											for(var v in tempReprocess)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempMend.length != 0)["","Mend",""],
										if(tempMend.length != 0)
											for(var v in tempMend)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempExpress.length != 0)["","Express",""],
										if(tempExpress.length != 0)
											for(var v in tempExpress)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempDye.length != 0)["","Dye",""],
										if(tempDye.length != 0)
											for(var v in tempDye)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempDryClean.length != 0)["","Dry Express",""],
										if(tempDryClean.length != 0)
											for(var v in tempDryClean)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempCharak.length != 0)["","Charak",""],
										if(tempCharak.length != 0)
											for(var v in tempCharak)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										
										if(tempCommercialWash.length != 0)["","Commercial Wash",""],
										if(tempCommercialWash.length != 0)
											for(var v in tempCommercialWash)
												['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
										
										if(tempStarch.length != 0)["","Starch",""],
										if(tempStarch.length != 0)
											for(var v in tempStarch)
												['${i++}', v.garmentObject.garmentName.toString(), v.quantity.toString()],
										[" ","             Total Garment", totalGarment.toString()],
									],
								),
							),
						]
					),
					
					pf.SizedBox(height: 20),
					
//					pf.Align(
//						alignment: pf.Alignment.bottomLeft,
//						child: pf.Row(
//							mainAxisAlignment: pf.MainAxisAlignment.spaceBetween,
//							children: <pf.Widget>[
//								pf.Column(
//										children: <pf.Widget>[
//											pf.Text("Terms & Condition:",style: pf.TextStyle(fontWeight: pf.FontWeight.bold)),
//											pf.Text("- term 1"),
//											pf.Text("- term 2"),
//										]
//								),
//
//								pf.Text("Other Information"),
//							]
//						)
//					)
				];
			}
		)
	);
}


savePdf() async{
	Directory documentDirectory = await getApplicationDocumentsDirectory();
	
	String documentPath = documentDirectory.path;
	File file = File("$documentPath/example.pdf");
	file.writeAsBytesSync(pdf.save());
}
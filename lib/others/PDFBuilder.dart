import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pf;
import 'package:path_provider/path_provider.dart';

var pdf;

writeInPdf(List<GarmentInBasket> temp, String string) async {
	pdf = pf.Document();
	int totalGarment = 0;
	print(temp.length);
	String s = '';
	ByteData bytes = await rootBundle.load('assets/hanger.png');
	Uint8List uint8list = bytes.buffer.asUint8List();
	for(var v in temp)
		totalGarment = totalGarment + v.quantity;
	
	print(temp.length);
	pdf.addPage(
		pf.MultiPage(
			pageFormat: PdfPageFormat.a4,
			margin: pf.EdgeInsets.only(left: 20,right: 20,top: 10),
			build: (pf.Context context){
				return <pf.Widget> [
					pf.Container(height: 50,color: PdfColor.fromHex("#083999"),
						child: pf.Row(
							mainAxisAlignment: pf.MainAxisAlignment.spaceBetween,
							children: <pf.Widget>[
								pf.Image(
									PdfImage.file(pdf.document, bytes: uint8list )
								),
								pf.Text("Westend Dry Cleaner", style: pf.TextStyle(fontSize: 20, color: PdfColors.white)),
								pf.Column(
									children: <pf.Widget>[
										pf.SizedBox(height: 20),
										pf.Text("OPEN ALL DAY: 10AM-8PM  ",style: pf.TextStyle(fontSize: 8, color: PdfColors.white)),
										pf.Text("www.westenddrycleaner.com   ",style: pf.TextStyle(fontSize: 8, color: PdfColors.white)),
									]
								)
							]
						)
					),
					
					pf.SizedBox(height: 20),
					pf.Align(
						alignment: pf.Alignment.center,
						child:pf.Text("Shop 20 Emaar Palm Drive Gurufram Sector 66",style: pf.TextStyle(fontWeight: pf.FontWeight.bold),textAlign: pf.TextAlign.center),
					),
					
					// pf.Align(
					// 	alignment: pf.Alignment.center,
					// 	child: pf.Text("Address Line1,Address Line 2,Address Line 3"),
					// ),
					pf.Align(
						alignment: pf.Alignment.center,
						child: pf.Text("Phone: 123456789"),
					),
					
					pf.SizedBox(height: 20),
					pf.Row(
						mainAxisAlignment: pf.MainAxisAlignment.spaceBetween,
						children: <pf.Widget>[
							pf.Text("       Challan No.: $string",textAlign: pf.TextAlign.right),
							pf.Text(" Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}"),
						]
					),
					pf.SizedBox(height: 20),
					
					pf.Column(
						children: <pf.Widget>[
							pf.Container(
								padding: pf.EdgeInsets.symmetric(horizontal: 20),
								child: pf.Table.fromTextArray(
									headerStyle: pf.TextStyle(
										color: PdfColors.black,
										fontWeight: pf.FontWeight.bold,
										fontStyle: pf.FontStyle.normal,
									),
									// headerDecoration: pf.BoxDecoration(
									// 		color: PdfColors.blue,
									// ),
									columnWidths: {
										1:pf.FlexColumnWidth()
									},
									
				          headers: ['Qty','Garment','Work'],
									border: pf.TableBorder(
										width: 2.0,
									),
									data: <List<String>>[
										for(var v in temp)
											[v.quantity.toString(), v.garmentObject.garmentName.toString(), v.nameOfWork],
									],
								),
							),
							pf.SizedBox(height: 10),
							pf.Divider(thickness: 3.0),
							pf.SizedBox(height: 20),
							
							pf.Row(
								children: <pf.Widget>[
									pf.SizedBox(height: 60),
									pf.Column(
										crossAxisAlignment: pf.CrossAxisAlignment.start,
										children: <pf.Widget>[
											pf.Text("LEAVE THE DIRTY WORK TO US",style: pf.TextStyle(fontWeight: pf.FontWeight.bold)),
											pf.RichText(
												text: pf.TextSpan(
													text: "PCS : ",
													style: pf.TextStyle(fontWeight: pf.FontWeight.bold),
													children: [
														pf.TextSpan(
															text: totalGarment.toString(),
														),
													]
												)
											)
										]
									),
								]
							)
							
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


savePdf(String name) async{
	Directory documentDirectory = await getApplicationDocumentsDirectory();
	String documentPath = documentDirectory.path;
	File file = File("$documentPath/${name.replaceAll("/", "r")}.pdf");
	// File file = File("$documentPath/example.pdf");
	file.writeAsBytesSync(pdf.save());
}

// STR001/PKJob19/51
import 'dart:io';
import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pf;
import 'package:path_provider/path_provider.dart';

final pdf = pf.Document();

writeInPdf(List<GarmentInBasket> temp){
	int totalGarment = 0;
	int i =1;
	
	print("l");
	var temp2 = [];
	temp2.addAll(temp);
	print(temp.length);
	temp2.removeWhere((element){
		return element.workAvailable.nameOfWork != 'Laundry';});
	print(temp2.length);
	var tempLaundry = temp2;
	print("1 "+tempLaundry.length.toString());
	
	temp2 = temp;
	temp2.removeWhere((element){
		print(element.workAvailable.nameOfWork);
		print(element.workAvailable.nameOfWork != 'Laundry Mix');
		return element.workAvailable.nameOfWork != 'Laundry Mix';});
	var tempLaundryMix = temp2;
	print("1 "+tempLaundryMix.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Charak';});
	var tempCharak = temp2;
	print("2 "+tempCharak.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Dry Clean';});
	var tempDryClean = temp2;
	print("3 "+tempDryClean.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Dye';});
	var tempDye = temp2;
	print("4 "+tempDye.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Express';});
	var tempExpress = temp2;
	print("5 "+tempExpress.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Mend';});
	var tempMend = temp2;
	print("6 "+tempMend.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Reprocess';});
	var tempReprocess = temp2;
	print("7 "+tempReprocess.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Steam Press';});
	var tempStreamPress = temp2;
	print("8 "+tempStreamPress.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Stiching';});
	var tempStiching = temp2;
	print("9 "+tempStiching.length.toString());
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'STARCH';});
	var tempStarch = temp2;
	print(tempStarch.length);
	print(temp.length);
	
	temp2 = temp;
	temp2.removeWhere((element){return element.workAvailable.nameOfWork != 'Commercial Wash';});
	var tempCommercialWash = temp2;
	print("10 " +tempCommercialWash.length.toString());
	print(temp.length);
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
					
					
					temp.any((element){
						return element.workAvailable.nameOfWork == 'Laundry';
					})?pf.Header(
						text: "Cloths Received",
					):pf.Container(),
					temp.any((element){
						return element.workAvailable.nameOfWork == 'Laundry';
					})?pf.Container(
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
								for(var v in tempLaundry)
									['${i++}',v.garmentObject.garmentName.toString(),v.quantity.toString()],
								[" ","             Total Garment", totalGarment.toString()],
							],
						),
					):pf.Container(),
					pf.SizedBox(height: 20),
					
					pf.Align(
						alignment: pf.Alignment.bottomLeft,
						child: pf.Row(
							mainAxisAlignment: pf.MainAxisAlignment.spaceBetween,
							children: <pf.Widget>[
								pf.Column(
										children: <pf.Widget>[
											pf.Text("Terms & Condition:",style: pf.TextStyle(fontWeight: pf.FontWeight.bold)),
											pf.Text("- term 1"),
											pf.Text("- term 2"),
										]
								),
								
								pf.Text("Other Information"),
							]
						)
					)
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
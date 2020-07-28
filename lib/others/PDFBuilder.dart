import 'dart:io';

import 'package:laundry/Classes/GarmentInBasket.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pf;
import 'package:path_provider/path_provider.dart';

final pdf = pf.Document();

writeInPdf(List<GarmentInBasket> temp){
	int totalGarment = 0;
	for(var v in temp)
		totalGarment = totalGarment + v.quantity;
	print(temp.length);
	pdf.addPage(
		pf.MultiPage(
			pageFormat: PdfPageFormat.a4,
			margin: pf.EdgeInsets.all(32),
			
			build: (pf.Context context){
				return <pf.Widget> [
					pf.Text("Job Id: 1234567899",textAlign: pf.TextAlign.right),
					pf.SizedBox(height: 20),
					
//							pf.Text("Address",style: pf.TextStyle(fontWeight: pf.FontWeight.bold),textAlign: pf.TextAlign.left),
					pf.Text("H.no,\nGali No.,\nTown,\nCity,\nPinCode",),
					
					pf.SizedBox(height: 40),
					
					pf.Header(
						text: "Cloths Received",
					),
					
					pf.Table.fromTextArray(
						headerStyle: pf.TextStyle(
							color: PdfColors.white,
							fontStyle: pf.FontStyle.normal,
							fontSize: 15,
						),
						headerDecoration: pf.BoxDecoration(
							color: PdfColors.black
						),
						headers: ['Name Of Garment', 'Quantity'],
						border: pf.TableBorder(
							width: 1.5,
						),
						data: <List<String>>[
							for(var v in temp)
								[v.garmentObject.garmentName.toString(),v.quantity.toString()],
							["Total Garment", totalGarment.toString()],
						],
						
						
					),
					
					pf.Text("Help line Number: 123456789"),
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
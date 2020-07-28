import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms/sms.dart';
import 'package:share_extend/share_extend.dart';

class PdfProviderScreen extends StatelessWidget {
	
	final String path;

  const PdfProviderScreen({Key key, this.path}) : super(key: key);
	
  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  appBar: AppBar(
			  title: Text("Challan Generator"),
			  actions: <Widget>[
			  	FlatButton(
					  child: Text("Share"),
					  onPressed: (){
					  	shareChallan();
					  },
				  )
			  ],
		  ),
	    body: Container(
		    padding: EdgeInsets.all(10),
		    child: Stack(
		      children: <Widget>[
		      	Container(
				      padding: EdgeInsets.all(10),
		      	  child: PDFView(
				        filePath: path,
			        ),
		      	),
		      ]),
	    ),
	  );
  }
  
  Future<void> shareChallan() async{
  	print("start");
  	try {
  		Directory dir = Platform.isAndroid?await getExternalStorageDirectory(): await getApplicationDocumentsDirectory();
  		File file = File(path);
  		if( ! await file.exists()){
  			await file.create(recursive: true);
  			file.writeAsStringSync("test for share document file");
		  }
  		ShareExtend.share(file.path, "file");
	  }catch(e){
  		print("error");
  		print(e);
	  }
  }
}

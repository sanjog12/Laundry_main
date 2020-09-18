import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/WorkerSection/Screen/JobAssigned.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class PdfProviderScreen extends StatelessWidget {
	final UserBasic userBasic;
	
	final String path;

  const PdfProviderScreen({Key key, this.path, this.userBasic}) : super(key: key);
	
  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  appBar: AppBar(
			  iconTheme: IconThemeData(
					  color: Colors.blue[100]
			  ),
			  title: Text("Challan Generator",style: TextStyle(
				  fontFamily: "OpenSans",
				  fontWeight: FontWeight.bold,
				  letterSpacing: 1.0,
				  color: Colors.blue[100],),),
			  centerTitle: true,
			  backgroundColor: Colors.blueGrey[700],
			  actions: <Widget>[
			  	FlatButton(
					  child: Icon(Icons.share,color: Colors.white,),
					  onPressed: (){
					  	shareChallan();
					  },
				  )
			  ],
		  ),
	    body: Container(
		    decoration: BoxDecoration(
			    image: DecorationImage(
					    image: AssetImage("images/12.jpg"),
					    fit: BoxFit.cover
			    ),
		    ),
		    padding: EdgeInsets.all(10),
		    child: Stack(
		      children: <Widget>[
		      	Container(
				      padding: EdgeInsets.all(10),
		      	  child: PDFView(
				        filePath: path,
			        ),
		      	),
			
			      Align(
				      alignment: AlignmentDirectional.bottomCenter,
				      child: Container(
					      padding: EdgeInsets.symmetric(horizontal: 120,vertical: 5),
					      height: 50,
					      width: MediaQuery.of(context).size.width,
					      decoration: BoxDecoration(
							      color: Color.fromRGBO(224,238,242, 1)
					      ),
					      child: Container(
						      height: 40,
						      width: 80,
						      decoration: BoxDecoration(
							      borderRadius: BorderRadius.circular(8),
							      color: Color.fromRGBO(2, 124, 149, 1),
						      ),
						      child: FlatButton(
								      child: Text("Completed",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontFamily: "Seguisb",fontSize: 20),),
								      onPressed: () {
									      Navigator.of(context).pop();
									      Navigator.of(context).pop();
									      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Work(
										      userBasic: userBasic,
									      )),);
								      }
						      ),
					      ),
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

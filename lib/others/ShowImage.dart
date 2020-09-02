import 'package:flutter/material.dart';


Future<bool> showImage(context, String url){
	
	return showDialog(
			context: context,
			builder: (BuildContext context) => ShowImage(
				url: url,
			),
	);
}


class ShowImage extends StatefulWidget {
	final String url;

  const ShowImage({Key key, this.url}) : super(key: key);
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
	    shape: RoundedRectangleBorder(
		    borderRadius: BorderRadius.circular(10),
	    ),
	    
	    content: Container(
		    child: Image.network(widget.url),
	    ),
    );
  }
}

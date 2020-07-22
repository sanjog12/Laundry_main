import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/others/Attendance.dart';

List<DateTime> presentDates = [];

List<DateTime> absentDates = [];

List<DateTime> halfDates = [];

class Attendance extends StatefulWidget{
  final UserBasic userBasic;

  const Attendance({Key key, this.userBasic}) : super(key: key);
@override
  State<StatefulWidget> createState() => AttendanceSate();

}

class AttendanceSate extends State<Attendance> {
  

  bool attend = true;
  CalendarCarousel _calendarCarouselNoHeader;
  
  static Widget absentIconTag(String day)=> Container(
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.all(
        Radius.circular(1000)
      )
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
  
  static Widget presentIconTag(String day)=> Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(
            Radius.circular(1000)
        )
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
  EventList<Event> dateMap = new EventList<Event>(
    events: {},
  );

  static Widget halfIconTag(String day)=> Container(
    decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.all(
            Radius.circular(1000)
        )
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
  
  getData() async{
    await getAttendance(widget.userBasic).then((value){
      setState(() {
        attend = false;
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    presentDates = [];
    absentDates = [];
    halfDates = [];
    getData();
  }
  
  
  @override
  Widget build(BuildContext context) {
    var cheight = MediaQuery.of(context).size.height;
    var len = presentDates.length;
    var len1 = absentDates.length;
    var len2 = halfDates.length;
    
    for(int i=0;i< len ; i++){
      dateMap.add(presentDates[i],
      new Event(
        date: presentDates[i],
        title: 'Event 1',
        icon: presentIconTag(
          presentDates[i].day.toString()
        )
      ));
    }
    
    for(int i=0;i<len1;i++){
      dateMap.add(absentDates[i],
          Event(
        date: absentDates[i],
        title: 'Event 1',
        icon: absentIconTag(
          absentDates[i].day.toString()
        )
      ));
    }

    for(int i=0;i<len2;i++){
      dateMap.add(halfDates[i],
          Event(
              date: halfDates[i],
              title: 'Event 1',
              icon: halfIconTag(
                  halfDates[i].day.toString()
              )
          ));
    }
    
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.blue[100]
          ),
          title: Text(
            "ATTENDANCE",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: Colors.blue[100],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[700],
        ),
        body: attend?Container(
          child: Center(
              child: CircularProgressIndicator(),
          ),
        )
            :Column(
          children: <Widget>[
            _calendarCarouselNoHeader =CalendarCarousel<Event>(
                  height: cheight * 0.54,
                  weekendTextStyle: TextStyle(
                    color: Colors.red
                  ),
              todayButtonColor: Colors.blue[100],
              markedDatesMap: dateMap,
              markedDateShowIcon: true,
              markedDateIconMaxShown: 1,
              markedDateMoreShowTotal: null,
              markedDateIconBuilder: (event){
                    return event.icon;
              },
            ),
            
            Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3.0
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  )
              ),
              child: Text("NUMBER OF PRESENTS: ${presentDates.length}",style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
  
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3.0
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  )
              ),
              child: Text("NUMBER OF PRESENTS: ${halfDates.length}",style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
            
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3.0
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  )
              ),
              child: Text("NUMBER OF ABSENTS: ${absentDates.length}",style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
            ),
            
          ],
        )
      );
  }
}
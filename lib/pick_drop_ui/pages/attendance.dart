import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, WeekdayFormat;
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
    height: 2,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(244, 41, 65, 1),
//      borderRadius: BorderRadius.all(
//        Radius.circular(10),
//      )
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
        color: Color.fromRGBO(0, 179, 50, 1),
       shape: BoxShape.circle
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
        color: Color.fromRGBO(252, 226, 5, 1),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _calendarCarouselNoHeader =CalendarCarousel<Event>(
              height: cheight * 0.5,
//              daysTextStyle: TextStyle(
//                color: Colors.blueAccent
//              ),
              weekendTextStyle: TextStyle(
                color: Colors.black,
              ),
              headerTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25
              ),
//              weekDayBackgroundColor: Colors.black,
              weekdayTextStyle: TextStyle(
                color: Color.fromRGBO(169, 169, 169, 1),
              ),
              prevMonthDayBorderColor: Color.fromRGBO(190, 190, 190, 1),
              nextMonthDayBorderColor: Color.fromRGBO(190, 190, 190, 1),
              todayButtonColor: Colors.blue[100],
              markedDatesMap: dateMap,
              markedDateCustomShapeBorder: CircleBorder(
              
              ),
              markedDateShowIcon: true,
              markedDateIconMaxShown: 1,
              markedDateMoreShowTotal: null,
              markedDateIconBuilder: (event){
                    return event.icon;
              },
            ),
            
//            Container(
//              margin: EdgeInsets.all(30.0),
//              padding: EdgeInsets.all(10.0),
//              decoration: BoxDecoration(
//                  border: Border.all(
//                      width: 3.0
//                  ),
//                  borderRadius: BorderRadius.all(
//                      Radius.circular(5.0)
//                  )
//              ),
//              child: Text("NUMBER OF PRESENTS: ${presentDates.length}",style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
//            ),
//
//            Container(
//              padding: EdgeInsets.all(10.0),
//              decoration: BoxDecoration(
//                  border: Border.all(
//                      width: 3.0
//                  ),
//                  borderRadius: BorderRadius.all(
//                      Radius.circular(5.0)
//                  )
//              ),
//              child: Text("NUMBER OF PRESENTS: ${halfDates.length}",style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
//            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 65,
//              padding: EdgeInsets.only(left: 20,right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO( 224, 238, 242, 1),
                    borderRadius: BorderRadius.circular(100)
                ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(left: 35.0),
                       child: Text("Present",style: TextStyle(fontFamily: "Myriad", fontSize: 32),),
                     ),
                     Container(
                       margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                       height: 45,
                       width: 60,
                       decoration: BoxDecoration(
                         border: Border.all(),
                         shape: BoxShape.circle,
                         color: Color.fromRGBO(0, 179, 50, 1),
                       ),
                       child: Center(
                         child: Text(
                           '${presentDates.length}',
                           style: TextStyle(fontFamily: "Myriad_Bold",fontSize: 30,fontWeight: FontWeight.w300, color: Colors.white),),
                       ),
                     )
                   ],
                 ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 65,
//              padding: EdgeInsets.only(left: 20,right: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO( 224, 238, 242, 1),
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text("Absent",style: TextStyle(fontFamily: "Myriad", fontSize: 32),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(244, 41, 65, 1),
                      ),
                      child: Center(
                        child: Text(
                          '${absentDates.length}',
                          style: TextStyle(fontFamily: "Myriad_Bold",fontSize: 30,fontWeight: FontWeight.w300, color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 65,
//              padding: EdgeInsets.only(left: 20,right: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO( 224, 238, 242, 1),
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text("Half Days",style: TextStyle(fontFamily: "Myriad", fontSize: 32),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(252, 226, 5, 1),
                      ),
                      child: Center(
                        child: Text(
                          '${halfDates.length}',
                          style: TextStyle(fontFamily: "Myriad_Bold",fontSize: 30,fontWeight: FontWeight.w300, color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      );
  }
}
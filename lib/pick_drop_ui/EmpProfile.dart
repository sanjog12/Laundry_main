//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/rendering.dart';
//import 'package:fl_chart/fl_chart.dart';
//class profile extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return LayoutBuilder(
//      builder: (context, constraints) {
//        return OrientationBuilder(
//          builder: (context, orientation) {
//            SizeConfig().init(constraints, orientation);
//            return MaterialApp(
//              debugShowCheckedModeBanner: false,
//              title: 'HomeScreen App',
//              home: ProfileFirst(),
//            );
//          },
//        );
//      },
//    );
//  }
//}
//class ProfileFirst extends StatefulWidget {
//  ProfileFirst({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _ProfileFirstState createState() => _ProfileFirstState();
//}
//
//class _ProfileFirstState extends State<ProfileFirst> {
//  double p=88;
//  double a=22;
//  List<PieChartSectionData>_sections = List<PieChartSectionData>();
//
//
//  @override
//  void initState(){
//    super.initState();
//    PieChartSectionData item1 =PieChartSectionData(color:Colors.green,
//        value:78,
//        title:"$p%",radius:44,
//        titleStyle: TextStyle(color:Colors.white,fontSize: 15.0));
//    PieChartSectionData item2 =PieChartSectionData(color:Colors.red,
//        value:22,
//        title:'$a%',radius:38,
//        titleStyle: TextStyle(color:Colors.white,fontSize: 12.0));
//    _sections=[item1,item2];
//  }
//
//
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color(0xffF8F8FA),
//      body: Stack(
//        overflow: Overflow.visible,
//        children: <Widget>[
//
//          Container(
//            color: Colors.blue[600],
//            height: 40 * SizeConfig.heightMultiplier,
//            child: Padding(
//              padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10 * SizeConfig.heightMultiplier),
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        height: 11 * SizeConfig.heightMultiplier,
//                        width: 22 * SizeConfig.widthMultiplier,
//                        decoration: BoxDecoration(
//                            shape: BoxShape.circle,
//                            image: DecorationImage(
//                                fit: BoxFit.cover,
//                                image: AssetImage("images/profileimg.png"))
//                        ),
//                      ),
//                      SizedBox(width: 5 * SizeConfig.widthMultiplier,),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text("Laundry Employee", style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 3 * SizeConfig.textMultiplier,
//                              fontWeight: FontWeight.bold
//                          ),),
//                          SizedBox(height: 1 * SizeConfig.heightMultiplier,),
//                          Padding(
//                            padding: EdgeInsets.only(right: 30.0),
//                            child: Text("EMP ID : LN6005050", style: TextStyle(
//                              color: Colors.white60,
//                              fontSize: 2.0 * SizeConfig.textMultiplier,
//                            ),),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(right: 30.0),
//                            child: Text("Mobile: 8899XXXXXX", style: TextStyle(
//                              color: Colors.white60,
//                              fontSize: 2.0 * SizeConfig.textMultiplier,
//                            ),),
//                          ),
//                          SizedBox(width: 7 * SizeConfig.widthMultiplier,),
//                        ],
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 3 * SizeConfig.heightMultiplier,),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                          Text("4.3", style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 3 * SizeConfig.textMultiplier,
//                              fontWeight: FontWeight.bold
//                          ),),
//                          Text("Rating", style: TextStyle(
//                            color: Colors.white70,
//                            fontSize: 1.9 * SizeConfig.textMultiplier,
//                          ),),
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Text("85%", style: TextStyle(
//                              color: Colors.white,
//                              fontSize: 3 * SizeConfig.textMultiplier,
//                              fontWeight: FontWeight.bold
//                          ),),
//                          Text("Completed/given", style: TextStyle(
//                            color: Colors.white70,
//                            fontSize: 1.9 * SizeConfig.textMultiplier,
//                          ),),
//                        ],
//                      ),
//                      Container(
//                        decoration: BoxDecoration(
//                          border: Border.all(color: Colors.white60),
//                          borderRadius: BorderRadius.circular(5.0),
//                        ),
//                        child: Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Text("EDIT PROFILE", style: TextStyle(
//                              color: Colors.white60,
//                              fontSize: 1.8 * SizeConfig.textMultiplier
//                          ),),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Padding(
//            padding:  EdgeInsets.only(top: 35 * SizeConfig.heightMultiplier),
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.only(
//                    topRight: Radius.circular(30.0),
//                    topLeft: Radius.circular(30.0),
//                  )
//              ),
//              child: Column(
//                  children: <Widget>[
//                    SizedBox(height: 7,),
//                    Text("This Month Details",
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black
//                      ),
//                    ),
//                  ]
//              ),
//            ),
//          ),
//          Row(
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(top: 190.0,left: 15.0),
//                child: Material(
//                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                  color: Colors.lightBlueAccent,
//                  elevation: 10.0,
//                  child: Container(
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(height:5),
//                        Text("Attendence",
//                          style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
//                        Padding(
//                          padding: EdgeInsets.only(top: 10.0),
//                          child: AspectRatio(
//                            aspectRatio: 1,
//                            child: PieChart(
//                              PieChartData(sections: _sections,
//                                borderData: FlBorderData(show: false),
//                                centerSpaceRadius: 50,sectionsSpace: 2,),
//                            ),
//                          ),
//                        ),
//                        SizedBox(height: 4,),
//                        Row(
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(top: 2.0,left: 20.0,right: 10.0),
//                              child: Material(
//                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                                color: Colors.green,
//                                elevation: 10.0,
//                                child: Container(
//                                  height: 20,
//                                  width: 20,
//                                ),
//                              ),
//                            ),
//                            Text(
//                              "Present",
//                              style: TextStyle(fontSize: 18.0,color: Colors.green,fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        ),
//                        SizedBox(height: 2,),
//                        Row(
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(top: 2.0,left: 20.0,right: 10.0),
//                              child: Material(
//                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                                color: Colors.red,
//                                elevation: 10.0,
//                                child: Container(
//                                  height: 20,
//                                  width: 20,
//                                ),
//                              ),
//                            ),
//                            Text(
//                              "Absent",
//                              style: TextStyle(fontSize: 18.0,color: Colors.redAccent,fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        )
//                      ],
//                    ),
//                    width: 190,
//                    height: 290,
//                  ),
//                ),
//              ),
//              Column(
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(top: 300.0,left: 15.0),
//                    child: Material(
//                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                      color: Colors.lightBlueAccent,
//                      elevation: 10.0,
//                      child: Container(
//                        child: Padding(
//                          padding: EdgeInsets.only(top: 40.0,left: 20.0),
//                          child: Text(
//                            "Progress...",
//                            style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),
//                          ),
//                        ),
//                        width: 170,
//                        height: 135,
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top:15.0,left: 15.0),
//                    child: Material(
//                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                      color: Colors.lightBlueAccent,
//                      elevation: 10.0,
//                      child: Container(
//                        child: Padding(
//                          padding: EdgeInsets.only(top: 40.0,left: 20.0),
//                          child: Text(
//                            "Progress...",
//                            style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),
//                          ),
//                        ),
//                        width: 170,
//                        height: 135,
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
//class SizeConfig {
//  static double _screenWidth;
//  static double _screenHeight;
//  static double _blockSizeHorizontal = 0;
//  static double _blockSizeVertical = 0;
//
//  static double textMultiplier;
//  static double imageSizeMultiplier;
//  static double heightMultiplier;
//  static double widthMultiplier;
//  static bool isPortrait = true;
//  static bool isMobilePortrait = false;
//  void init(BoxConstraints constraints, Orientation orientation) {
//    if (orientation == Orientation.portrait) {
//      _screenWidth = constraints.maxWidth;
//      _screenHeight = constraints.maxHeight;
//      isPortrait = true;
//      if (_screenWidth < 450) {
//        isMobilePortrait = true;
//      }
//    } else {
//      _screenWidth = constraints.maxHeight;
//      _screenHeight = constraints.maxWidth;
//      isPortrait = false;
//      isMobilePortrait = false;
//    }
//
//    _blockSizeHorizontal = _screenWidth / 100;
//    _blockSizeVertical = _screenHeight / 100;
//
//    textMultiplier = _blockSizeVertical;
//    imageSizeMultiplier = _blockSizeHorizontal;
//    heightMultiplier = _blockSizeVertical;
//    widthMultiplier = _blockSizeHorizontal;
//
//    print(_blockSizeHorizontal);
//    print(_blockSizeVertical);
//  }
//}
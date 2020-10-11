import 'dart:math';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Services/AuthServices.dart';
import 'package:laundry/Services/LocalNotification.dart';
import 'package:laundry/others/ToastOutputs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:laundry/HomePage.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  
  
  String email = ' ';
  String password = ' ';
  GlobalKey<FormState> key = GlobalKey<FormState>();
  UserAuth userAuth = UserAuth();
  AuthServices _auth = AuthServices();
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference dbf;
  
  bool buttonLoading = false;
  
  locationPermission() async{
    var f = await Permission.location.isGranted;
    if(!f){
      await Permission.location.request();
    }
  }
  
  Future<dynamic> alertPop() async{
    return await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Administrator"),
                Divider(thickness: 1,),
              ],
            ),
            content: Text("Your location data is necessary"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                  locationPermission();
                },
              )
            ],
          );
        }
    );
  }
  
  @override
  void initState() {
    super.initState();
    locationPermission();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final ThemeData themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(

              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: EdgeInsets.only(left:45.0,right: 45.0),
                  child: Container(
                    height: 140,
                    width: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/wdclogo.png'),fit: BoxFit.fill)
                    ),

                  ),
                ),
                SizedBox(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                ),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Registered Mobile Number" , style: TextStyle(fontFamily: 'Myriad_Bold',fontSize: 15
                      ),),



                      TextFormField(
                        maxLength: 10,
                        decoration: InputDecoration(),
                        onChanged: (value){
                          userAuth.mobileNo = value;
                        },

                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Text("Password",style: TextStyle(fontFamily: 'Myriad_Bold',fontSize: 15 ),),

                      TextFormField(
                        decoration: InputDecoration(),
                        onChanged: (value){
                          password = value;
                          userAuth.password = value;
                        },
                      ),
                      
                      SizedBox(
                        height: 5,
                      ),


//                        Container(
//                          alignment: Alignment.centerRight,
//                          child: InkWell(
//
//                            onTap: () {
////										      enterEmailDialog();
//                            },
//
//                            child: Text(
//                              "Forgot Password?",
//                              style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                          ),
//                        ),


                      SizedBox(
                        height: 50,
                      ),


                      SizedBox(
                        height: 30,
                      ),

//                        Wrap(
//                          crossAxisAlignment: WrapCrossAlignment.center,
//                          children: <Widget>[
//                            Text("Dont have an account?",style: TextStyle(
//                            ),),
//                            Container(
//                              padding: EdgeInsets.symmetric(
//                                horizontal: 10.0,
//                              ),
//                              child: InkWell(
//                                onTap: () {
//                                  Navigator.of(context)
//                                      .push(MaterialPageRoute(builder: (context)=>SignUp()));
//                                },
//                                child: Text(
//                                  "Sign Up",
//                                  style: TextStyle(
//                                    color: Colors.black54,
//                                    fontWeight: FontWeight.bold,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(2, 124, 149, 1)
                  ),
                  height: 50,
                  width: 180,
                  child:FlatButton(
                    child: buttonLoading?
                    Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>
                          (Colors.white70),
                      ),
                    )
                        :Text("Login",style: TextStyle(fontFamily: 'Myriad_Bold',color: Color.fromRGBO(255, 255, 255, 1),fontSize: 20),),
                    onPressed: (){
                      loginUser(userAuth,context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  LatLng convert(double i,double j){
    return LatLng(i,j);
  }
  
  
  
  Future<void> loginUser(UserAuth authDetails,BuildContext context) async {
    
    try {
      if (key.currentState.validate()) {
        key.currentState.save();
        this.setState(() {
          buttonLoading = true;
        });
      
        UserBasic userBasic = await _auth.loginUser(authDetails,context);
        if (userBasic != null) {
          NotificationServices().setReminderNotification(id: Random.secure().nextInt(10000),
              titleString: "Reminder",
              bodyString: "Please Ensure that you logout in the app",
              scheduleTime: DateTime.now().add(Duration(hours: int.parse(userBasic.hours.split(":")[0],),minutes: 30)));
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userBasic: userBasic,
              )
            )
          );
          toastMessage(message: "Login Successfully");
        } else{
//          toastMessage(message: "Wrong Credential");
        }
      }
    } on PlatformException catch (e) {
      toastMessage(message: e.message.toString());
    } catch (e) {
      print(e);
      toastMessage(message: "Something Went Wrong");
    } finally {
      this.setState(() {
        buttonLoading = false;
      });
    }
  }
  
}

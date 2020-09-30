import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:flutter/services.dart';
import 'package:laundry/Services/AuthServices.dart';
import 'package:laundry/others/ToastOutputs.dart';
import 'package:location/location.dart';
import 'package:laundry/others/Style.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  
  
  String email = ' ';
  String password = ' ';
  LocationData currentLocation;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  UserAuth userAuth = UserAuth();
  AuthServices _auth = AuthServices();
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference dbf;
  
  Location location = Location();
  
  bool buttonLoading = false;
  
  locationPermission() async{
    PermissionStatus s = await location.hasPermission();
    if(s.index==0){
      location.requestPermission();
    }
    currentLocation = await location.getLocation();
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
        child: Stack(
          children:<Widget> [
  
            Container(
						height: size.height,
						width: size.width,
						child: Image.asset('images/12.jpg',
							colorBlendMode: BlendMode.saturation,
							fit: BoxFit.fill,
							height: double.infinity,
							width: double.infinity,
						),
					),
            
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  
                  Text("Welcome" , style: themeData.textTheme.headline.merge(TextStyle(
                      fontSize: 26,
                      color: Colors.black
                  
                  ),),),
                  
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign in to Continue",
                    style: themeData.textTheme.subhead.merge(TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w300
                    )),
                  ),
                  
                  SizedBox(
                    height: 70,
                  ),
                  
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Registered Mobile Number" , style: TextStyle(
                        ),),
                        
                        SizedBox(
                          height: 10,
                        ),
                        
                        TextFormField(
                          maxLength: 10,
                          decoration: buildCustomInput(hintText: 'Registered Mobile Number'),
                          onChanged: (value){
                            userAuth.mobileNo = value;
                          },
                        ),
                        
                        SizedBox(
                          height: 30,
                        ),
                        
                        Text("Password",),
                        
                        SizedBox(
                          height: 10,
                        ),
                        
                        TextFormField(
                          decoration: buildCustomInput(hintText: "Password"),
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
                          height: 80,
                        ),
                        
                        
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                          ),
                          height: 50,
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
                                :Text("Login"),
                            onPressed: (){
                              loginUser(userAuth,context);
                            },
                          ),
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
                ],
              ),
            ),
          ]
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

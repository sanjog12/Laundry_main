import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:flutter/services.dart';
import 'package:laundry/Services/AuthServices.dart';
import 'package:laundry/authentication/AuthScreens/Signup.dart';
import 'package:laundry/others/Style.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';



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
  
  bool buttonLoading = false;
  
  
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
                    height: 50,
                  ),
                  
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Email Address" , style: TextStyle(
                        ),),
                        
                        SizedBox(
                          height: 10,
                        ),
                        
                        TextFormField(
                          decoration: buildCustomInput(hintText: 'Email Address'),
                          onSaved: (value){
                            email = value;
                            userAuth.email = value;
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
                          onSaved: (value){
                            password = value;
                            userAuth.password = value;
                          },
                        ),
                        
                        
                        SizedBox(
                          height: 5,
                        ),
                        
                        
                        Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            
                            onTap: () {
//										      enterEmailDialog();
                            },
                            
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        
                        SizedBox(
                          height: 100,
                        ),
                        
                        
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                          ),
                          height: 50,
//                          color: Colors.grey,
                          child:FlatButton(
//                              color: Colors.grey,
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
                              loginUser(userAuth);
                            },
                          ),
                        ),
                        
                        SizedBox(
                          height: 30,
                        ),
                        
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text("Dont have an account?",style: TextStyle(
                            ),),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context)=>SignUp()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          ),]
        ),
      ),
    );
  }
  
  
  
  Future<void> loginUser(UserAuth authDetails) async {
    try {
      if (key.currentState.validate()) {
        key.currentState.save();
        this.setState(() {
          buttonLoading = true;
        });
      
        UserBasic userBasic = await _auth.loginUser(authDetails);
        print(userBasic.phoneNumber);
        print(userBasic.email);
        if(userBasic.userType != "admin") {
          if (double.parse(userBasic.long) == 0) {
            throw("Wait for the administrative actions");
          }
        }
        
        if(userBasic.userType != "admin"){
          double  d = await distanceFormStore( LatLng(currentLocation.latitude,currentLocation.longitude),
              LatLng(double.parse(userBasic.lat),double.parse(userBasic.long)));
          if(d>10){
            throw("You are not present at your work place");
          }
        }
        int month= DateTime.now().month;
        int year = DateTime.now().year;
        int date = DateTime.now().day;
        String time=DateFormat("kk:mm:ss").format(DateTime.now());
        firebaseDatabase.reference().child("Attendance").child(userBasic.uid).child(year.toString()).child(month.toString()).set({
          date.toString() : time
      
        if (userBasic != null) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userBasic: userBasic,
              )
            )
          );
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xff666666),
              textColor: Colors.white,
              fontSize: 16.0);
        } else {}
      }
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff666666),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Unable to login at the moment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff666666),
          textColor: Colors.white,
          fontSize: 16.0);
    } finally {
      this.setState(() {
        buttonLoading = false;
      });
    }
  }
  
}

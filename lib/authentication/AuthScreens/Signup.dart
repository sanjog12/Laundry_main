import 'package:flutter/material.dart';
import 'package:laundry/Classes/UserBasic.dart';
import 'package:laundry/Classes/UserDetails.dart';
import 'package:laundry/Services/AuthServices.dart';
import 'package:laundry/others/Style.dart';
import 'package:laundry/others/Validator.dart';
import 'package:laundry/pick_drop_ui/home_page.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
	GlobalKey<FormState> key = GlobalKey<FormState>();
	User user = User();
	bool submitButtonLoading = false;
	
	@override
	Widget build(BuildContext context) {
		
		final size = MediaQuery.of(context).size;
		final ThemeData theme = Theme.of(context);
		final TextEditingController _pass = TextEditingController();
		
		return Scaffold(
			body: Stack(
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
					
					SingleChildScrollView(
						child: Container(
							padding: EdgeInsets.all(24),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: <Widget>[
									
									SizedBox(
										height: 50,
									),
									Text("Create Account" , style: theme.textTheme.headline.merge(TextStyle(
										fontSize: 24,
									)),),
									
									Text("Welcome User Register Yourself",
										style: TextStyle(

										),
									),
									
									
									SizedBox(
										height: 50,
									),
									
									Form(
										key: key,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: <Widget>[
												Text("Full Name ",style: TextStyle(
												),),
												
												SizedBox(
													height: 10,
												),
												
												TextFormField(
													decoration: buildCustomInput(hintText: "Full Name"),
													onSaved: (value){
														user.name = value;
														
													},
													
													validator: (String value){
														return requiredField(value, "Full Name");
													},
												),
												
												SizedBox(
													height: 30,
												),
												
												Column(
													crossAxisAlignment: CrossAxisAlignment.stretch,
													children: <Widget>[
														Text("Email Address",style: TextStyle(
														),),
														
														SizedBox(
															height: 10,
														),
														
														TextFormField(
															validator: (String value){
																return validateEmail(value);
															},
															onSaved: (String value){
																user.email = value;
															},
															
															decoration: buildCustomInput(hintText: "Email Address"),
															keyboardType: TextInputType.emailAddress,
														)
													],
												),
												
												SizedBox(
													height: 30,
												),
												
												Column(
													crossAxisAlignment: CrossAxisAlignment.stretch,
													children: <Widget>[
														Text("Password" , style: TextStyle(
														),),
														SizedBox(
															height: 10,
														),
														
														TextFormField(
															controller: _pass,
															validator: (String value){
																return validatePasswordLength(value);
															},
															onSaved: (value){
																user.password=value;
															},
															decoration: buildCustomInput(hintText: "Password"),
															obscureText: true,
														
														)
													],
												),
												
												SizedBox(height: 30,),
												
												Column(
													crossAxisAlignment: CrossAxisAlignment.stretch,
													children: <Widget>[
														Text("Confirm Password", style: TextStyle(
														),),
														
														SizedBox(
															height: 10,
														),
														
														TextFormField(
															validator: (String v){
																return validatePasswordMatch(v, _pass.text);
															},
															decoration: buildCustomInput(hintText: "Password"),
															obscureText: true,
														)
													],
												),
												
												SizedBox(
													height: 30,
												),
												
												Column(
													crossAxisAlignment: CrossAxisAlignment.stretch,
													children: <Widget>[
														
														Text("Mobile Number", style: TextStyle(
														),),
														
														SizedBox(height: 10),
														
														TextFormField(
															validator: (String v){
																return requiredField(v, "Phone Number");
															},
															decoration: buildCustomInput(hintText: "Phone Number"),
															onSaved: (String value){
																user.phoneNumber = value;
															},
															keyboardType: TextInputType.number,
														
														),
													],
												),
												
												SizedBox(height: 30,),
												
												Container(
													child: FlatButton(
														color: Colors.black54,
														child
																:submitButtonLoading
																?Center(
															child: CircularProgressIndicator(),
														)
																:Text("Sign up", style: TextStyle(
															color: Colors.white
														),),
														onPressed: (){
															createUser();
														},
													),
												)
											],
										),
									),
								],
							),
						),
					),
				],
			),
		);
	}
	
	
	Future<void> createUser() async {
		if (key.currentState.validate()) {
			key.currentState.save();
			this.setState(() {
				submitButtonLoading = true;
			});
			AuthServices _authService = AuthServices();
			User _user = await _authService.registerUser(user);
			this.setState(() {
				submitButtonLoading = false;
			});
			if (_user != null) {
					print(_user);
					Navigator.pop(context);
					Navigator.push(
						context,
						MaterialPageRoute(
							builder: (context) => HomePage(
							user: _user,
							)
						)
					);
//        Navigator.of(context).pushReplacementNamed(PersonalInfoRoute);
			} else {
				print("Didnt create");
			}
		}
	}
}

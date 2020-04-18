
import 'package:url_launcher/url_launcher.dart';

get_navigation(){
	/*
	   Navigating to the work places and other places is done using this function  in the following url we can pass
	   location variable and driving mode .
	 */
	launch('https://www.google.com/maps/dir/?api=1&destination=28.640884,77.126071&dir_action=navigate&travelmode=two_wheeler');
}
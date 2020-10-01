import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{


//	int notificationId = ;
	FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
	AndroidInitializationSettings androidInitializationSettings;
	IOSInitializationSettings iosInitializationSettings;
	InitializationSettings initializationSettings;
	
	void initializeSetting() async{
		androidInitializationSettings = AndroidInitializationSettings("ic_launcher");
		initializationSettings = InitializationSettings(androidInitializationSettings , iosInitializationSettings);
		await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
	}
	
	
	void showNotification(String titleString, String bodyString) async{
		await _notification(titleString,bodyString);
	}
	
	
	void setReminderNotification({int id ,String titleString, String bodyString, DateTime scheduleTime}) async{
		await reminderNotificationService(id: id,titleString: titleString, bodyString: bodyString,scheduleTime: scheduleTime);
	}
	
	
	
	Future<void> _notification(String titleString, String bodyString) async{
		print(titleString);
		print(bodyString);
		AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
			'Channel _ID',
			'Channel title',
			'channel body',
			priority: Priority.High,
			importance: Importance.Max,
			ticker: 'test',
		);
		
		IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
		
		NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
		await flutterLocalNotificationsPlugin.show(0, titleString, bodyString, notificationDetails);
	}
	
	
	
	Future<void> reminderNotificationService({int id ,String titleString, String bodyString,DateTime scheduleTime}) async{
		
		AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
			'Channel _ID',
			'Channel title',
			'channel body',
			priority: Priority.High,
			importance: Importance.Max,
			ticker: 'test',
			enableLights: true,
		);
		
		IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
		
		NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
		await flutterLocalNotificationsPlugin.schedule(id, titleString, bodyString, scheduleTime, notificationDetails);
	}
	
	Future<void> onSelectNotification(String payLoad) async{
		
		if(payLoad != null){
			print(payLoad);
		}
	}
	
	Future<void> deleteNotification(int id) async{
		await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation().cancel(id);
	}
	
	// Future<void> notificationRecord(Client client,String id,DateTime time) async{
	// 	final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
	// 	DatabaseReference dbf;
	// 	String uid = await SharedPrefs.getStringPreference('uid');
	// 	String a1 = time.toString().split(" ")[0];
	// 	List<String> a2 = a1.split('-');
	// 	String date = "${a2[2]}-${a2[1]}-${a2[0]}";
	// 	dbf = firebaseDatabase.reference();
	// 	dbf
	// 			.child("NotificationWork")
	// 			.child(uid)
	// 			.child(client.email)
	// 			.child(id)
	// 			.set(date);
	// }
	
}
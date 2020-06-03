

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
	final Firestore _firestore = Firestore.instance;
	
	dynamic getUserDetails(firebaseUserId) {
		return _firestore
				.collection('Laundry User')
				.document('firebaseUserId')
				.snapshots();
	}
}
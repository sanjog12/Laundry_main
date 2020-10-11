

import 'package:laundry/Classes/UserAuth.dart';
import 'package:laundry/Classes/UserBasic.dart';

class Authenticate{
	
	validateUser(UserBasic userBasic,UserAuth userAuth) {
		
		if(userBasic.isActive == 'true'){
			if(userAuth.mobileNo != userAuth.mobileNo)
				throw('Wrong Credentials');
//
//			if(userAuth.password != userBasic.password)
//				throw('Wrong Credentials');
		}
		else{
			throw('No longer a Employee');
		}
	}
}
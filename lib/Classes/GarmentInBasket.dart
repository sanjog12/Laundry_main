

import 'package:laundry/Classes/Garment.dart';
import 'package:laundry/Classes/WorkAvailable.dart';

class GarmentInBasket{
	GarmentObject garmentObject;
	int quantity;
	List<WorkAvailable> workAvailable;
	String nameOfWork;
	String jobIdJson;
	
	GarmentInBasket({
		this.garmentObject,
		this.quantity,
		this.workAvailable,
		this.nameOfWork,
		this.jobIdJson,
	});
}
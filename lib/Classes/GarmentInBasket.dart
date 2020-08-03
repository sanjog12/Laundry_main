import 'package:laundry/Classes/Garment.dart';
import 'package:laundry/Classes/WorkAvailable.dart';

class GarmentInBasket{
	GarmentObject garmentObject;
	int quantity;
	String workToBeDone;
	WorkAvailable workAvailable;
	
	GarmentInBasket({
		this.garmentObject,
		this.quantity,
		this.workToBeDone,
		this.workAvailable,
	});
}
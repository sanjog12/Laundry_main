import 'package:geocoding/geocoding.dart';

class Job{
	String id, customerId, storeId, jobId, jobName, userId, isCompleted, isPending, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted, store, customerName;
	String customerAddress, customerMobile, userName, completed, pending;
	Location location;
	Job({
		this.id, this.storeId, this.isDeleted, this.createdDate,
		this.createdBy, this.customerName,
		this.completed, this.customerAddress, this.customerId,
		this.customerMobile, this.isCompleted, this.isPending,
		this.jobId, this.jobName, this.modifiedBy,
		this.modifiedDate, this.pending, this.store,
		this.userId, this.userName,
		this.location
	});
}
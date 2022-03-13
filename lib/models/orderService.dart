class OrderService {
  int id;
  int serviceId;
  String orderDate;
  String orderDescription;
  String referenceId;
  String orderStatus;
  String orderBy;
  String vendor;

  OrderService(
      {this.id,
      this.serviceId,
      this.orderDate,
      this.orderDescription,
      this.referenceId,
      this.orderStatus,
      this.orderBy,
      this.vendor});

  OrderService.fromJson(Map<String, dynamic> data) {
    id = data['ID'];
    serviceId = data['ServiceID'];
    orderDate = data['OrderDate'];
    orderDescription = data['OrderDescription'];
    referenceId = data['ReferenceID'];
    orderStatus = data['OrderStatus'];
    orderBy = data['OrderBy'];
    vendor = data['Vendor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ServiceID': serviceId,
      'OrderDate': orderDate,
      'OrderDescription': orderDescription,
      'ReferenceID': referenceId,
      'OrderStatus': orderStatus,
      'OrderBy': orderBy,
      'Vendor': vendor,
    };
  }
}

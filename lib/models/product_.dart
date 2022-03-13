import 'package:hive/hive.dart';

part 'product_.g.dart';

@HiveType()
class Product_ extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String owner;
  @HiveField(4)
  String category;
  @HiveField(5)
  String cropImage;
  @HiveField(6)
  String banner1;
  @HiveField(7)
  String banner2;
  @HiveField(8)
  int price;
  @HiveField(9)
  String status;
  @HiveField(10)
  String pricetype;
  @HiveField(11)
  int quantity;
  @HiveField(12)
  double totalPrice;
  @HiveField(13)
  String referenceId;

  Product_(
      {this.id,
      this.name,
      this.description,
      this.owner,
      this.category,
      this.cropImage,
      this.banner1,
      this.banner2,
      this.price,
      this.status,
      this.pricetype,
      this.quantity,
      this.totalPrice,
      this.referenceId});

  Product_.fromJson(Map<String, dynamic> data) {
    id = data['ID'];
    name = data['Name'];
    description = data['Description'];
    owner = data['Owner'];
    category = data['Category'];
    cropImage = data['CropImage'];
    banner1 = data['Banner1'];
    banner2 = data['Banner2'];
    price = data['Price'];
    status = data['Status'];
    pricetype = data['PriceType'];
    quantity = data['quantity'];
    totalPrice = data['totalPrice'];
    referenceId = data['referenceId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Description': description,
      'Owner': owner,
      'Category': category,
      'CropImage': cropImage,
      'Banner1': banner1,
      'Banner2': banner2,
      'Price': price,
      'Status': status,
      'PriceType': pricetype,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'referenceId':referenceId
    };
  }
}

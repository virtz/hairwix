class Product {
  int id;
  String name;
  String description;
  String owner;
  String category;
  String cropImage;
  String banner1;
  String banner2;
  int price;
  String status;
  String pricetype;
  int quantity;

  Product(this.quantity,
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
      this.pricetype});

  Product.fromJson(Map<String, dynamic> data) {
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
      'quantity':quantity    };
  }

  // String toString() => "Product<$name>";
}

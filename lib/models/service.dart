class Service {
  int id;
  String name;
  String description;
  String owner;
  String address;
  String phone1;
  String phone2;
  String category;
  String openHours;
  String email;
  String website;
  String cropImage;
  String banner1;
  String banner2;
  String priceDescription;
  String area;
  String state;
  String country;
  String status;

  Service(
      this.id,
      this.name,
      this.description,
      this.owner,
      this.address,
      this.phone1,
      this.phone2,
      this.category,
      this.openHours,
      this.email,
      this.website,
      this.cropImage,
      this.banner1,
      this.banner2,
      this.priceDescription,
      this.area,
      this.state,
      this.country,
      this.status);

  Service.fromJson(Map<String, dynamic> data) {
    id = data['ID'];
    name = data['Name'];
    description = data['Description'];
    owner = data['Owner'];
    address = data['Address'];
    phone1 = data['Phone1'];
    phone2 = data['Phone2'];
    category = data['Category'];
    openHours = data['OpenHours'];
    email = data['Email'];
    website = data['Website'];
    cropImage = data['CropImage'];
    banner1 = data['Banner1'];
    banner2 = data['Banner2'];
    priceDescription = data['Price_Description'];
    area = data['Area'];
    state = data['State'];
    country = data['Country'];
    status = data['Status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Description': description,
      'Owner': owner,
      'Address': address,
      'Phone1': phone1,
      'Phone2': phone2,
      'Category': category,
      'OpenHours': openHours,
      'Email': email,
      'Website': website,
      'CropImage': cropImage,
      'Banner1': banner1,
      'Banner2': banner2,
      'Price_Description': priceDescription,
      'Area': area,
      'Country': country,
      'Status': status
    };
  }

  String toString() => "Service<$name>";
}

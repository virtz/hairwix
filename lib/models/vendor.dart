class Vendor {
  int id;
  String username;
  String licenseStatus;
  String startDate;
  String endDate;
  String logoUrl;

  Vendor(
      {this.id,
      this.username,
      this.licenseStatus,
      this.startDate,
      this.endDate,
      this.logoUrl});

  Vendor.fromJson(Map<String, dynamic> data) {
    id = data['ID'];
    username = data['Username'];
    licenseStatus = data['LicenseStatus'];
    startDate = data['StartDate'];
    endDate = data['EndDate'];
    logoUrl = data['assets/images/placeholder.png'];
  }
  Map<String, dynamic> toJson() {
    return {
      'ID':id,
      'Username':username,
      'LicenseStatus':licenseStatus,
      'StartDate':startDate,
      'EndDate':endDate,
      'assets/images/placeholder.png':logoUrl,
    };
  }
}

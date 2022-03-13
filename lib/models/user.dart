class User {
  int id;
  String username;
  String usertype;
  String fullname;
  String password;
  String profilepic;
  String phone;
  String email;

  User(
      {this.id,
      this.username,
      this.usertype,
      this.fullname,
      this.password,
      this.profilepic,
      this.phone,
      this.email});

  User.fromJson(Map<String, dynamic> data) {
    id = data['ID'];
    username = data['Username'];
    usertype = data['UserType'];
    fullname = data['Fullname'];
    password = data['Password'];
    profilepic = data['ProfilePic'];
    phone = data['Phone'];
    email = data['Email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Username': username,
      'Usertype': usertype,
      'Fullname': fullname,
      'Password': password,
      'ProfilePic': profilepic,
      'Phone': phone,
      'Email': email
    };
  }

  String toString() => "User<$username>";
}

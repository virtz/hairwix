import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/pages/editProfile.dart';
import 'package:hairmarket/pages/myOrders.dart';
import 'package:hairmarket/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(
      context,
    );
    userProvider.getCurrentUser();

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    // var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              return FutureBuilder(
                future: userProvider.getCurrentUser(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.red,
                        ),
                      );
                      break;
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.blue,
                        ),
                      );
                      break;
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.yellow));
                      break;
                    case ConnectionState.done:
                      print(snapshot);
                      var user = userProvider.users[0];
                      if (snapshot.hasError || userProvider.users.length ==0 ) {
                        return Center(child: Text("An error occurred"));

                      } else {
                      return buildProfile(user);
                      }
                      break;
                    default:
                      return Center(
                        child: Text('An error occurred'),
                      );
                  }
                },
              );
            },
          )),
    );
  }

  Widget buildProfile(user) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: size.height,
        child: Stack(
          children: [
            Container(
                height: ScreenUtil.mediaQueryData.size.height / 2.4,
                width: size.width,
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 72,
                        backgroundColor: Colors.lightGreenAccent,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilepic),
                          radius: 70,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20.0),
                      ),
                      Text(user.username,
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
                      ),
                      Text(user.email,
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: ScreenUtil().setHeight(10.0),
                      ),
                      // Text(user.phone,
                      //     style: GoogleFonts.montserrat(
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.w400)),
                    ],
                  ),
                )),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                // color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.create),
                      )),
                ),
              ),
            ),
            Positioned(
                top: 250.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                    height: size.height,
                    // color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 20.w),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.w, horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditProfile(
                                              username: user.username,
                                              fullname: user.fullname,
                                              usertype: user.usertype,
                                              email: user.email,
                                              password: user.password,
                                              profilepic: user.profilepic,
                                              phone: user.phone)));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person,
                                            size: 30, color: Colors.green),
                                        SizedBox(width: 10),
                                        Text('Edit profile',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 15.0)
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyOrder()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.track_changes,
                                            size: 30, color: Colors.green),
                                        SizedBox(width: 10),
                                        Text('My Orders',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 15.0)
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.settings,
                                          size: 30, color: Colors.green),
                                      SizedBox(width: 10),
                                      Text('Settings',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 15.0)
                                ],
                              ),
                              Spacer(),
                              Divider(),
                              GestureDetector(
                                onTap: () async {
                                  final RenderBox box =
                                      context.findRenderObject();
                                  await Share.share('www.google.com',
                                      // 'invite a friend',
                                      subject: 'Invite a friend',
                                      sharePositionOrigin:
                                          box.localToGlobal(Offset.zero) &
                                              box.size);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person_add,
                                            size: 30, color: Colors.green),
                                        SizedBox(width: 10),
                                        Text('Invite a friend',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios, size: 15.0)
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.question_answer,
                                          size: 30, color: Colors.green),
                                      SizedBox(width: 10),
                                      Text('Help',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 15.0)
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.exit_to_app,
                                          size: 30, color: Colors.green),
                                      SizedBox(width: 10),
                                      Text('Sign out',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 15.0)
                                ],
                              ),
                              Spacer(
                                flex: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/pages/order_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Services extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final String owner;
  final String address;
  final String phone1;
  final String phone2;
  final String category;
  final String openHours;
  final String email;
  final String website;
  final String cropImage;
  final String banner1;
  final String banner2;
  final String priceDescription;
  final String area;
  final String state;
  final String country;
  final String status;

  const Services(
      {Key key,
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
      this.status})
      : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  Future<void> makeCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw ('Could not launch $url');
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> mail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw ('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: widget.email,
        queryParameters: {'subject': ''});


    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                      height: ScreenUtil.mediaQueryData.size.height / 2.4,
                      width: size.width,
                      child: Hero(
                        tag: widget.cropImage,
                        child: Image(image: NetworkImage(widget.cropImage)),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BackButton(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 250,
                      bottom: 70,
                      left: 0,
                      right: 0.0,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          elevation: 3.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 20.w),
                            child: Container(
                              // height: ScreenUtil.mediaQueryData.size.height,
                              child: Column(
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.name,
                                        // maxLines: 2,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          width: size.width / 2.3,
                                          height: ScreenUtil().setHeight(200),
                                          child: Image(
                                              image: NetworkImage(
                                                  widget?.banner2)),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          width: size.width / 2.3,
                                          height: ScreenUtil().setHeight(200),
                                          child: Image(
                                              image: NetworkImage(
                                                  widget?.banner1)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Description',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.description,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color: Colors.grey)),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Row(
                                    children: [
                                      Text('Servitor/Consultant : ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            // color:Colors.grey,
                                          )),
                                      Text(widget.owner,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0, color: Colors.grey
                                              // color:Colors.grey,
                                              )),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Address',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.address,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color: Colors.grey)),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Contact Info',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(7)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          makeCall('tel:${widget.phone1}');
                                        },
                                        child: Text(widget.phone1,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                color: Colors.grey)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          makeCall('tel:${widget.phone2}');
                                        },
                                        child: Text(widget.phone2,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(7)),
                                  GestureDetector(
                                    onTap: () {
                                      _launchInBrowser(widget.website);
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(widget.website,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(7)),
                                  GestureDetector(
                                    onTap: () {
                                      mail(_emailLaunchUri.toString());
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(widget.email,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Open Hours',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.openHours,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0, color: Colors.grey
                                            // color:Colors.grey,
                                            )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Price Type : ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.priceDescription,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0, color: Colors.grey
                                            // color:Colors.grey,
                                            )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Location ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Row(
                                    children: [
                                      Text("${widget.area}, ",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0, color: Colors.grey
                                              // color:Colors.grey,
                                              )),
                                      Text("${widget.state}, ",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0, color: Colors.grey
                                              // color:Colors.grey,
                                              )),
                                      Text("${widget.country}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0, color: Colors.grey
                                              // color:Colors.grey,
                                              )),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              )),
        ),
        bottomNavigationBar: Container(
            height: 80,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Order(
                    serviceid: widget.id,
                    servicename: widget.name,
                  );
                }));
              },
              child: Text('Order Now',
                  style: GoogleFonts.montserrat(
                      fontSize: 17.0, color: Colors.white)),
            )),
      ),
    );
  }
}

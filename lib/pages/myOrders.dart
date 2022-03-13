import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/providers/orderServiceProvider.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    var orderServiceProvider = Provider.of<OrderServiceProvider>(context);
    orderServiceProvider.getOrders();

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('My Orders',
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: orderServiceProvider.getOrders(),
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: orderServiceProvider.orders.length == 0
                    ? Center(child: Text('You have not made any others yet'))
                    : ListView.builder(
                        itemCount: orderServiceProvider.orders.length,
                        itemBuilder: (context, index) {
                          var order = orderServiceProvider.orders[index];
                          return Card(
                              child: Container(
                            height: ScreenUtil.mediaQueryData.size.height / 4.5,
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Order Status : ',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            // fontWeight: FontWeight.w400
                                          )),
                                      Text(order.orderStatus,
                                          style: GoogleFonts.montserrat(
                                            color:
                                                order.orderStatus == "Pending"
                                                    ? Colors.red
                                                    : Colors.green,
                                            fontSize: 13.0,
                                            // fontWeight: FontWeight.w400
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("Vendor/Servitor : ",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            // fontWeight: FontWeight.w400
                                          )),
                                      Text(order.vendor,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            // fontWeight: FontWeight.w400
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  // Text("Here's your order description :",
                                  //     style: GoogleFonts.montserrat(
                                  //       color: Colors.grey,
                                  //       fontSize: 13.0,
                                  //       // fontWeight: FontWeight.w400
                                  //     )),
                                  // Text(order.orderDescription,
                                  //     style: GoogleFonts.montserrat(
                                  //       // color: Colors.grey,
                                  //       fontSize: 13.0,

                                  //       // fontWeight: FontWeight.w400
                                  //     ),maxLines: 3,),
                                  Row(
                                    children: [
                                      Text("You made this order on : "),
                                      Text(order.orderDate.substring(0, 10)),
                                      Text(" at " +
                                          order.orderDate.substring(12, 16)),
                                    ],
                                  ),
                                  Spacer(),
                                  //    Text("Here's your order description :",
                                  // style: GoogleFonts.montserrat(
                                  //   color: Colors.grey,
                                  //   fontSize: 13.0,
                                  //   // fontWeight: FontWeight.w400
                                  // )),
                                  Text(
                                    '" ' + order.orderDescription + '... "',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontSize: 13.5,

                                      // fontWeight: FontWeight.w400
                                    ),
                                    maxLines: 3,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ));
                        },
                      ),
              );
            default:
              return Center(
                child: Text('An error occurred'),
              );
          }
        },
      ),
    );
  }
}

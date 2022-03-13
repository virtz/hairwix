import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/models/product_.dart';
import 'package:hairmarket/pages/webViewPage.dart';
import 'package:hairmarket/providers/cartProvider.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    // var size = MediaQuery.of(context).size;

    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
            style: GoogleFonts.montserrat(fontSize: 17.0, color: Colors.black
                // color:Colors.grey,
                )),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: cartProvider.getCart(),
          builder: (BuildContext context, snapshot) {
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
              case ConnectionState.done:
                // print(snapshot.data);
                return cartProvider.products.length == 0
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Container(
                         height:ScreenUtil().setHeight(150),
                                  child: SvgPicture.asset(
                                      'assets/images/emptyCart.svg')),
                                      SizedBox(height: 15,),
                    Text('Your cart is empty at the moment',style: GoogleFonts.montserrat(
                          fontSize: 12.0,
                          color: Colors.black,
                          // color:Colors.grey,
                          fontWeight: FontWeight.w400))
                      ])
                    : _buildListView();
                break;
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.yellow));
                break;
              default:
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.green));
            }

            //prorduct['name];
          },
        ),
      ),
    );
  }

  Widget _buildListView() {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    cartProvider.updateTotalPice();
    var cartList = cartProvider.products;
    var totalList = cartList.map((e) => e.quantity);
    var totalQuantity = totalList.isEmpty
        ? 0.0
        : totalList.reduce((value, element) => value + element);

    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              height: ScreenUtil().setHeight(50),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total',
                      style: GoogleFonts.montserrat(
                          fontSize: 17.0, color: Colors.black
                          // color:Colors.grey,
                          )),
                  Text("#" + cartProvider.total.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 17.0,
                          color: Colors.black,
                          // color:Colors.grey,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Container(
              height: ScreenUtil().setHeight(50),
              width: size.width,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.green,
                onPressed: () {
                  orderCart(
                      cartProvider.total, totalQuantity, cartProvider.products);
                },
                child: cartProvider.isLoading()
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white, strokeWidth: 2)
                    : Text('Check Out',
                        style: GoogleFonts.montserrat(
                            fontSize: 15.0, color: Colors.white)),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cartProvider.products.length,
              itemBuilder: (context, index) {
                Product_ product = cartProvider.products[index];

                // cartProvider.products[index].totalPrice = totalPrice;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Card(
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 15.w),
                        child: Row(
                          children: [
                            Container(
                                height: ScreenUtil().setHeight(140),
                                width: size.width / 3,
                                child: Image(
                                    image: NetworkImage(product.cropImage))),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name,
                                      maxLines: 2,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 17.0, color: Colors.black
                                          // color:Colors.grey,

                                          )),
                                  Spacer(),
                                  Text(product.pricetype,
                                      maxLines: 2,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14.0,
                                        // color: Colors.black,
                                        color: Colors.grey,
                                      )),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () =>
                                        cartProvider.deleteProduct(index),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.delete),
                                        Text('Tap to delete',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          "#" +
                                              product.price
                                                  .toDouble()
                                                  .toString(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.black
                                              // color:Colors.grey,
                                              )),
                                      // Spacer(),
                                      SizedBox(
                                        width: ScreenUtil
                                                .mediaQueryData.size.width /
                                            10,
                                      ),
                                      Container(
                                        height: 30,
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 20.0,
                                              child: RawMaterialButton(
                                                onPressed: () => cartProvider
                                                    .subAndUpdateData(
                                                        index, product),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.green,
                                                  size: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: Text(
                                                product.quantity.toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Container(
                                              width: 20.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.green),
                                              child: Center(
                                                child: RawMaterialButton(
                                                  onPressed: () => cartProvider
                                                      .addAndUpdateData(
                                                          index, product),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
    // });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  orderCart(totalPrice, totalQuantity, List products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullname = prefs.getString('username');
    var referenceId = prefs.getString('referenceId');
    var email = prefs.getString('email');
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.orderCart(totalPrice, totalQuantity);
    cartProvider.orderProductInCart(products).whenComplete(() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => WebViewPage(
                fullname: fullname,
                referenceId: referenceId,
                email: email,
              )));
    });
  }
}

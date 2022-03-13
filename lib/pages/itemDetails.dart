import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/models/product_.dart';
import 'package:hairmarket/pages/tab_screens/cart.dart';

import 'package:hairmarket/providers/cartProvider.dart';

import 'package:provider/provider.dart';

class ItemDetails extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final String owner;
  final String category;
  final String cropImage;
  final String banner1;
  final String banner2;
  final int price;
  final String status;
  final String pricetype;

  const ItemDetails(
      {Key key,
      this.id,
      this.name,
      this.description,
      this.owner,
      this.category,
      this.cropImage,
      this.banner1,
      this.banner2,
      this.price,
      this.status,
      this.pricetype})
      : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int quantity = 0;
  double totalPrice = 0.0;

  void addQty() {
    setState(() {
      quantity++;
    });
  }

  void subQty() {
    setState(() {
      if (quantity != 1) {
        quantity--;
      } else if (quantity < 1) {
        setState(() {
          quantity = 1;
        });
      }
    });
  }

  void mutpl(price) {
    setState(() {
      totalPrice = price * quantity;
      print(totalPrice);
    });
  }

  _showCupertinoDialog(BuildContext context) {
    // Provider.of<UserProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
              title: new Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
              content: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text('Quantity can not be 0')),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
//  double totalPrice = quantity * widget.price
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.updateTotalPice();
    var cartList = cartProvider.products;
    var totalList = cartList.map((e) => e.quantity);
    var totalQuantity = totalList.isEmpty
        ? 0.0
        : totalList.reduce((value, element) => value + element);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  height: ScreenUtil.mediaQueryData.size.height / 2.4,
                  width: size.width,
                  child: Hero(
                      tag: widget.cropImage,
                      child: Image(image: NetworkImage(widget.cropImage))),
                ),
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
                    child: Column(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 20.w),
                            child: Container(
                              height: ScreenUtil.mediaQueryData.size.height,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(widget.name,
                                        // maxLines: 2,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("#" + widget.price.toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16.0,
                                          )),
                                      // FutureBuilder(
                                      //     future: Hive.openBox('cart'),
                                      // builder: (context, snapshot) {
                                      IconButton(
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            addToCart();
                                          })
                                      // })
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // RatingBar(
                                      //   itemSize: 17,
                                      //   initialRating: 4.5,
                                      //   minRating: 1,
                                      //   direction: Axis.horizontal,
                                      //   allowHalfRating: true,
                                      //   itemCount: 5,

                                      //   // itemPadding:
                                      //   // EdgeInsets.symmetric(horizontal: 4.0),

                                      //   onRatingUpdate: (rating) {
                                      //     print(rating);
                                      //   },
                                      // ),
                                      RatingBar.builder(
                                        initialRating: 4.5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize:17,
                                        // itemPadding: EdgeInsets.symmetric(
                                        //     horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 30.0,
                                              child: RawMaterialButton(
                                                onPressed: () {
                                                  subQty();
                                                  mutpl(
                                                      widget.price.toDouble());
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.green,
                                                  size: 25.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: Text(
                                                quantity.toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Container(
                                              width: 30.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.green),
                                              child: Center(
                                                child: RawMaterialButton(
                                                  onPressed: () {
                                                    addQty();
                                                    mutpl(widget.price
                                                        .toDouble());
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 25.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
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
                                    children: <Widget>[
                                      Text('Vendor :',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 17.0,
                                            // color: Colors.grey,
                                          )),
                                      Text(" ${widget.owner}",
                                          //  widget.owner,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16.0,
                                            // color: Colors.grey,
                                          ))
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Other Images',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 17.0,
                                          // color:Colors.grey,
                                        )),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
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
                                  Row(
                                    children: [
                                      Text('Price Type :',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            // color: Colors.grey,
                                          )),
                                      Text(" ${widget.pricetype}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                  Row(
                                    children: [
                                      Text('Product Category :',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            // color: Colors.grey,
                                          )),
                                      Text(" ${widget.category}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Container(height:size.height/3,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
                buynow(
                    cartProvider.total, totalQuantity, cartProvider.products);
              },
              child: cartProvider.isLoading()
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white, strokeWidth: 2)
                  : Text('Buy Now',
                      style: GoogleFonts.montserrat(
                          fontSize: 17.0, color: Colors.white)),
            )),
      ),
    );
  }

  buynow(total, totalQuantity, List products) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    var product = Product_(
        quantity: quantity,
        id: widget.id,
        name: widget.name,
        description: widget.description,
        owner: widget.owner,
        category: widget.category,
        cropImage: widget.cropImage,
        banner1: widget.banner1,
        banner2: widget.banner2,
        price: widget.price,
        status: widget.status,
        pricetype: widget.pricetype,
        totalPrice: totalPrice);

    if (quantity == 0) {
      _showCupertinoDialog(context);
    } else {
      await cartProvider.addToCart(product).whenComplete(() {
        print(product);

        cartProvider.updateTotalPice();
        // cartProvider.orderCart(total, totalQuantity);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => Cart()));
      });
    }
  }

  addToCart() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    var product = Product_(
        quantity: quantity,
        id: widget.id,
        name: widget.name,
        description: widget.description,
        owner: widget.owner,
        category: widget.category,
        cropImage: widget.cropImage,
        banner1: widget.banner1,
        banner2: widget.banner2,
        price: widget.price,
        status: widget.status,
        pricetype: widget.pricetype,
        totalPrice: totalPrice);

    var existingItem = cartProvider.products
        .firstWhere((element) => element.id == product.id, orElse: () => null);
    if (existingItem != null) {
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        titleText: Center(
            child: Text('Product already in cart',
                style: GoogleFonts.montserrat(
                    fontSize: 15.0, color: Colors.blue))),
        messageText: Text(''),
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      if (quantity == 0) {
        _showCupertinoDialog(context);
      } else {
        await cartProvider.addToCart(product).then((value) {
          // var cartProdId = cartProvider.products.map((e) => e.id);
        }).catchError((e) => print(e));

        Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          titleText: Center(
              child: Text('Product added to cart',
                  style: GoogleFonts.montserrat(
                      fontSize: 15.0, color: Colors.blue))),
          messageText: Text(''),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    }
  }

  @override
  void dispose() {
    // Hive.box('cart').close();
    super.dispose();
  }
}

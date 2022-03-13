
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hairmarket/pages/itemDetails.dart';
import 'package:hairmarket/pages/newArrivals.dart';
import 'package:hairmarket/pages/offers.dart';
import 'package:hairmarket/pages/popular.dart';
import 'package:hairmarket/pages/reccommended.dart';
import 'package:hairmarket/pages/services.dart';
import 'package:hairmarket/pages/vendor.dart';
import 'package:hairmarket/providers/productProvider.dart';
import 'package:hairmarket/providers/serviceProvider.dart';
import 'package:hairmarket/providers/vendorProvider.dart';
import 'package:hairmarket/utils/hair2.dart';
import 'package:hairmarket/utils/hair3.dart';
import 'package:hairmarket/utils/hair4.dart';
import 'package:hairmarket/utils/vendors.dart';
import 'package:hairmarket/utils/wigAccessories.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String _connectionStatus = 'Unknown';
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }

  //   if (!mounted) {
  //     return Future.value(null);
  //   }

  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //     case ConnectivityResult.none:
  //       setState(() => _connectionStatus = result.toString());
  //       break;
  //     default:
  //       setState(() => _connectionStatus = 'Failed to get connectivity.');
  //       print(_connectionStatus);
  //       break;
  //   }
  // }

  @override
  void initState() {
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductsProvider>(context, listen: false);
    productProvider.getProducts();
    var serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.getService();
    var vendorProvider = Provider.of<VendorProvider>(context, listen: false);
    vendorProvider.getVendors();

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('HairWix',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.0)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: ScreenUtil.mediaQueryData.size.width,
                    child: TextFormField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFFFFFFFF),
                        hintText: 'Search name,price, vendor',
                        suffixIcon: Icon(Icons.search),
                        // suffixIconConstraints:  BoxConstraints(maxHeight: 20.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFD8D8DF), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Color(0xFFD8D8DF), width: 1),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                BorderSide(color: Color(0xFFD8D8DF), width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(50),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Recommended for you',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('We picked out these all for you',
                                style: TextStyle(color: Colors.grey)),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Recommended()));
                              },
                              child: Text('See more.',
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      // Consumer<ProductsProvider>(
                      //     builder: (context, productProvider, _) {
                      Container(
                        height: size.height / 2.4,
                        child: FutureBuilder(
                            future: productProvider.getProducts(),
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
                                case ConnectionState.done:
                                  // print(snapshot.data);
                                  return ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                            width: ScreenUtil().setWidth(10)),
                                    itemCount: productProvider.products.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var product =
                                          productProvider.products[index];
                                      return productProvider.products.length ==
                                              0
                                          ? Text('Items will appear in a sec')
                                          : buildRecommended(context, product);
                                    },
                                  );
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
                            }),
                      ),
                      // }
                      // ),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Popular',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('You may also like',
                                      style: TextStyle(color: Colors.grey)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PopularProducts()));
                                    },
                                    child: Text('See more.',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(200),
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: hairs1.length,
                            itemBuilder: (context, index) {
                              return buildPopular(context, index);
                            }),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(60)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Featured Vendors',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Recommended()));
                                  },
                                  child: Text('See more.',
                                      style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            Container(
                              height: ScreenUtil().setHeight(250),
                              child: FutureBuilder(
                                  future: vendorProvider.getVendors(),
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
                                      case ConnectionState.done:
                                        return GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 0.80,
                                                    mainAxisSpacing: 7,
                                                    crossAxisSpacing: 5,
                                                    crossAxisCount: 3),
                                            itemCount:
                                                vendorProvider.vendors.length,
                                            itemBuilder: (context, index) {
                                              var vendor =
                                                  vendorProvider.vendors[index];
                                              return buildFeatured(
                                                  context, vendor);
                                            });
                                        break;
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.yellow));
                                        break;
                                      default:
                                        return Center(
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.green));
                                    }
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(60)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Hair Accessories',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('You may also like',
                                    style: TextStyle(color: Colors.grey)),
                                Text('See more.',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            Container(
                              height: ScreenUtil().setHeight(250),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.80,
                                          mainAxisSpacing: 7,
                                          crossAxisSpacing: 5,
                                          crossAxisCount: 3),
                                  itemCount: vendors.length,
                                  itemBuilder: (context, index) {
                                    return buildWigAccessories(context, index);
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(60)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Services',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('At your convenience, we serve',
                                    style: TextStyle(color: Colors.grey)),
                                Text('See more.',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            Container(
                              height: ScreenUtil().setHeight(200),
                              width: double.infinity,
                              child: FutureBuilder(
                                future: serviceProvider.getService(),
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
                                    case ConnectionState.done:
                                      // print(snapshot.data);
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              serviceProvider.services.length,
                                          itemBuilder: (context, index) {
                                            var service =
                                                serviceProvider.services[index];
                                            return buildServiceCard(
                                                context, service);
                                          });
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
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(60)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('New Arrivals',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('They just came in',
                                      style: TextStyle(color: Colors.grey)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  NewArrivals()));
                                    },
                                    child: Text('See more.',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(200),
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: hairs1.length,
                            itemBuilder: (context, index) {
                              return buildNewArrivals(context, index);
                            }),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(30)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Offers',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Slashed prices just for you',
                                      style: TextStyle(color: Colors.grey)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Offers()));
                                    },
                                    child: Text('See more.',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(200),
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: hairs1.length,
                            itemBuilder: (context, index) {
                              return buildOffersCard(context, index);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//recommeneded wigs card
  Widget buildRecommended(BuildContext context, product) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ItemDetails(
            id: product.id,
            name: product.name,
            cropImage: product.cropImage,
            description: product.description,
            price: product.price,
            owner: product.owner,
            pricetype: product.pricetype,
            banner1: product.banner1,
            banner2: product.banner2,
            category: product.category,
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              width: size.width / 2.2,
              // height: size.height / 4,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: product.cropImage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          width: size.width / 2.2,
                          height: ScreenUtil().setHeight(200),
                          child: Image(
                            image: NetworkImage(
                              product.cropImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      product.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '#' + product.price.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(Icons.shopping_cart, size: 27, color: Colors.green)
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

//popular wigs card
  Widget buildPopular(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return ItemDetails(
        //       name: hairs1[index].title,
        //       cropImage: hairs1[index].imgUrl,
        //       description: hairs1[index].description,
        //       price: hairs1[index].price);
        // }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            width: ScreenUtil().setWidth(150),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: hairs1[index].imgUrl,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: ScreenUtil().setHeight(100),
                        // ScreenUtil.mediaQueryData.size.height/8,
                        child: Image(
                          image: AssetImage(
                            hairs1[index].imgUrl,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(hairs1[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14))),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(hairs1[index].price, style: TextStyle(fontSize: 12)),
                    Icon(Icons.shopping_cart, size: 20, color: Colors.green)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//featured vendors card
  Widget buildFeatured(BuildContext context, vendor) {
    vendor.logoUrl = 'assets/images/placeholder.png';
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Vendor(
            username: vendor.username,
            imgUrl: vendor.logoUrl,
            startDate: vendor.startDate,
            licenseStatus: vendor.licenseStatus,
            endDate: vendor.endDate,
          );
        }));
      },
      child: Container(
        // color: Colors.grey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: ScreenUtil().setHeight(70),
                  child: Image(
                    image: AssetImage(vendor.logoUrl),
                  )),
            ),
            Text(vendor.username)
          ],
        ),
      ),
    );
  }

  Widget buildWigAccessories(BuildContext context, int index) {
    return Container(
      // color: Colors.grey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
                tag: wigAccessories[index].imgUrl,
                child: Container(
                    height: ScreenUtil().setHeight(70),
                    child: Image(
                      image: AssetImage(wigAccessories[index].imgUrl),
                    ))),
          ),
          Text(wigAccessories[index].name)
        ],
      ),
    );
  }

//new arrivals wig card
  Widget buildNewArrivals(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return ItemDetails(
        //       title: hairs3[index].title,
        //       imgUrl: hairs3[index].imgUrl,
        //       description: hairs3[index].description,
        //       price: hairs3[index].price);
        // }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            width: ScreenUtil().setWidth(150),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: hairs3[index].imgUrl,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: ScreenUtil().setHeight(100),
                        // ScreenUtil.mediaQueryData.size.height/8,
                        child: Image(
                          image: AssetImage(
                            hairs3[index].imgUrl,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(hairs3[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14))),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(hairs3[index].price, style: TextStyle(fontSize: 12)),
                    Icon(Icons.shopping_cart, size: 20, color: Colors.green)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildServiceCard(BuildContext context, service) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Services(
              id: service.id,
              name: service.name,
              description: service.description,
              owner: service.owner,
              address: service.address,
              phone1: service.phone1,
              phone2: service.phone2,
              category: service.category,
              openHours: service.openHours,
              email: service.email,
              website: service.website,
              cropImage: service.cropImage,
              banner1: service.banner1,
              banner2: service.banner2,
              priceDescription: service.priceDescription,
              area: service.area,
              state: service.state,
              country: service.country,
              status: service.status);
        }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            width: ScreenUtil().setWidth(150),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: service.cropImage,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(130),
                          // ScreenUtil.mediaQueryData.size.height/8,
                          child: Image(
                            image: NetworkImage(
                              service.cropImage,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Text(service.name,
                    maxLines: 2,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOffersCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return ItemDetails(
        //       title: hairs4[index].title,
        //       imgUrl: hairs4[index].imgUrl,
        //       description: hairs4[index].description,
        //       price: hairs4[index].price);
        // }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Container(
            width: ScreenUtil().setWidth(150),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: hairs4[index].imgUrl,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: ScreenUtil().setHeight(100),
                        // ScreenUtil.mediaQueryData.size.height/8,
                        child: Image(
                          image: AssetImage(
                            hairs4[index].imgUrl,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(hairs4[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14))),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(hairs4[index].price, style: TextStyle(fontSize: 12)),
                    Icon(Icons.shopping_cart, size: 20, color: Colors.green)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

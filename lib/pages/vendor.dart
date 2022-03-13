import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/pages/itemDetails.dart';
import 'package:hairmarket/pages/services.dart';
import 'package:hairmarket/providers/vendorProvider.dart';

import 'package:provider/provider.dart';

class Vendor extends StatefulWidget {
  final String username;
  final String imgUrl;
  final String licenseStatus;
  final String startDate;
  final String endDate;

  const Vendor(
      {Key key,
      this.username,
      this.imgUrl,
      this.licenseStatus,
      this.startDate,
      this.endDate})
      : super(key: key);

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      child: Text('Products'),
    ),
    Tab(child: Text('Services')),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var vendorProvider = Provider.of<VendorProvider>(context, listen: false);

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    // var size = MediaQuery.of(context).size;

    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(controller: _controller, tabs: list),
                  title: Text(widget.username,
                      style: GoogleFonts.montserrat(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  centerTitle: true,
                ),
                body: TabBarView(controller: _controller, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.w),
                    child: FutureBuilder(
                      future: vendorProvider.getVendorProduct(widget.username),
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
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.80,
                                          mainAxisSpacing: 7,
                                          crossAxisSpacing: 5,
                                          crossAxisCount: 2),
                                  itemCount: vendorProvider.products.length,
                                  itemBuilder: (context, index) {
                                    var product =
                                        vendorProvider.products[index];
                                    print(vendorProvider.products.length);
                                    return vendorProvider.products.length == null
                                        ? Center(
                                            child: Text(
                                                'Vendor product list is empty'))
                                        : buildProductCard(context, product);
                                  }),
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
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.w),
                    child: FutureBuilder(
                      future: vendorProvider.getVendorService(widget.username),
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
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.80,
                                          mainAxisSpacing: 7,
                                          crossAxisSpacing: 5,
                                          crossAxisCount: 2),
                                  itemCount: vendorProvider.services.length,
                                  itemBuilder: (context, index) {
                                    var service =
                                        vendorProvider.services[index];
                                    return vendorProvider.services.length == 0
                                        ? Center(
                                            child: Text(
                                            'Vendor service list is empty',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                        : buildServiceCard(context, service);
                                  }),
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
                      },
                    ),
                  ),
                ]))));
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
                SizedBox(height: ScreenUtil().setHeight(20)),
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

  Widget buildProductCard(BuildContext context, product) {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Container(
            width: ScreenUtil().setWidth(150),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: product.cropImage,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: ScreenUtil().setHeight(100),
                        // ScreenUtil.mediaQueryData.size.height/8,
                        child: Image(
                          image: NetworkImage(
                            product.cropImage,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(product.name,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Colors.black))),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('#' + product.price.toString(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: Colors.black)),
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



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairmarket/utils/hair2.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
     double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);
    // var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Popular Products', style: bigtextStyle()),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal:18.w,vertical: 10.w),
          child: GridView.builder(
             physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.80,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2),
              itemCount: hairs1.length,
              itemBuilder: (context, index) {
                return buildProductCard(context, index);
              }),
        ),
      ),
    );
  }

  TextStyle bigtextStyle() {
    return GoogleFonts.montserrat(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    return Card(
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
    );
  }
}

   

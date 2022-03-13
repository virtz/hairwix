import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hairmarket/models/product.dart';
import 'package:hairmarket/models/service.dart';
import 'package:hairmarket/models/vendor.dart';
import 'package:hairmarket/services/productService.dart';
import 'package:hairmarket/services/serviceService.dart';
// import 'package:hairmarket/pages/vendor.dart';
import 'package:hairmarket/services/vendorService.dart';

class VendorProvider with ChangeNotifier {
  var vendors = List<Vendor>();
  var products = List<Product>();
  var services = List<Service>();
  var message;
  var errorMessage;
  bool loading = false;

  getVendors() async {
    try {
      await VendorService.getVendors().then((response) {
        Iterable list = response.data;
        vendors = list.map((model) => Vendor.fromJson(model)).toList();
        return vendors;
      });
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    }
  }

  getVendorProduct(String username) async {
    try {
      await ProductService.getProducts().then((response) {
        Iterable list = response.data;
        products = list
            .map((model) => Product.fromJson(model))
            .where((i) => i.owner == username)
            .toList();
        return products;
      });
      notifyListeners();
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    }
  }

  getVendorService(String username) async {
    try {
      await ServicesService.getServices().then((response) {
        Iterable list = response.data;
        services = list
            .map((model) => Service.fromJson(model))
            .where((i) => i.owner == username)
            .toList();
        return services;
      });
      notifyListeners();
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    }
  }

  bool isLoading() {
    return loading;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setMessage(value) {
    message = value;
    notifyListeners();
  }

  String getMessage() {
    return message;
  }

  void setErrorMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getErrorMessage() {
    return errorMessage;
  }
}

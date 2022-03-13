import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hairmarket/models/orderService.dart';
import 'package:hairmarket/services/orderService_service.dart';

class OrderServiceProvider with ChangeNotifier {
  var message;
  var errorMessage;
  bool loading = false;
  var orders = List<OrderService>();

  orderService(description, id) async {
    setLoading(true);
    try {
      message = await OrderServices.orderService(description, id).then((value) {
        return value;
      });
      print("from provider $message");
      // notifyListeners();
      setLoading(false);
      if (message != null) {
        setMessage('Success');
      }
    } on DioError catch (e) {
      setLoading(false);
      print(e);
      setErrorMessage(e.response.toString());
    }
  }

  getOrders() async {
    try {
      await OrderServices.getOrders().then((response) {
        Iterable list = response.data;
        orders = list.map((model) => OrderService.fromJson(model)).toList();
        return orders;
      });
    } on DioError catch (e) {
      setErrorMessage(e.response.toString());
    } on SocketException catch (e) {
      setErrorMessage(e.message.toString());
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

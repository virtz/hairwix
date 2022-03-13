import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hairmarket/models/service.dart';
import 'package:hairmarket/services/serviceService.dart';

class ServiceProvider with ChangeNotifier {
  var message;
  var errorMessage;
  var services = List<Service>();
  bool loading = false;

  getService() async {
    
    try {
      await ServicesService.getServices().then((response) {
        Iterable list = response.data;
        services = list.map((model) => Service.fromJson(model)).toList();
        return services;
      });
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

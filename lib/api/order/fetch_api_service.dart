import 'dart:convert';

import 'package:ecommerce_app/api/api_url.dart';
import 'package:ecommerce_app/models/order_response.dart';
import 'package:ecommerce_app/models/UserResponse.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FetchApiOrderService {
  final logger = Logger();

  //singleTon Partern
  static final FetchApiOrderService instance = FetchApiOrderService._internal();
  factory FetchApiOrderService() {
    return instance;
  }
  FetchApiOrderService._internal();
  final header = <String, String>{'Content-Type': 'application/json'};

  // code here
  Future<OrderResponse?> getOrderByUserId(String id) async {
    var url = Uri.parse(ApiUrl.apiGetOrderByUserId + id);
    try {
      final response = await http.get(url, headers: header);

      var order = OrderResponse.fromJson(jsonDecode(response.body));
      logger.i('response: ${order.id}');

      return order;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<OrderResponse?> createOrder() async {
    var url = Uri.parse(ApiUrl.apiCreateOrder);
    try {
      final response = await http.get(url, headers: header);

      var order = OrderResponse.fromJson(jsonDecode(response.body));
      //logger.i('response: ${order.data?[0].id}');

      return order;
    } catch (e) {
      throw Exception(e);
    }
  }
}
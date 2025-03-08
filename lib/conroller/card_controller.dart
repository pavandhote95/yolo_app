
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CardController extends GetxController {
  var isFrozen = false.obs;
  var cardNumber = "0000\n0000\n0000\n0000".obs;
  var expiry = "00/00".obs;
  var cvv = "***".obs;
  var showCVV = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCardDetails();
  }

  Future<void> fetchCardDetails() async {
    final response = await http.get(Uri.parse("http://localhost:3000/card"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      cardNumber.value = data["number"];
      expiry.value = data["expiry"];
      cvv.value = data["cvv"];
    }
  }
}
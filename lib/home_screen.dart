import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardController controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenWidth * 0.08;
    double fontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Color(0xFF0D0D0D),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Text("Select Payment Mode",
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: screenHeight * 0.02),
            Text("Choose your preferred payment method to \n make payment",
                style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey)),
            SizedBox(height: screenHeight * 0.04),
            Row(
              children: [
                Image.asset("assets/images/p.png", width: screenWidth * 0.3),
                Image.asset("assets/images/c.png", width: screenWidth * 0.3),
              ],
            ),
            SizedBox(height: screenHeight * 0.06),
            Text("YOUR DIGITAL DEBIT CARD",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: screenHeight * 0.04),
        Row(
              children: [
                Obx(() => controller.isFrozen.value
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.35, // 28% of screen height
  width: MediaQuery.of(context).size.width * 0.4, 
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.grey[900]!, Colors.black]),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            border: Border.all(
                                color: const Color.fromARGB(255, 53, 52, 52))),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/yolo.png",
                                    width: iconSize),
                                Image.asset("assets/images/yes.png",
                                    width: iconSize),
                              ],
                            ),
                            SizedBox(height: 20),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: controller.isFrozen.value ? 0.1 : 1.0,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: controller.cardNumber.isNotEmpty
                                      ? controller.cardNumber
                                          .split(RegExp(
                                              r'\s|-')) // Split number based on space or dash
                                          .map((segment) => FadeInDown(
                                            duration: Duration(seconds: 1),
                                            child: Text(segment,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ))
                                          .toList()
                                      : [
                                          Text('Load...',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white))
                                        ],
                                ),
                                SizedBox(width: 29),
                                FadeInDown(
                                  duration: Duration(seconds: 1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("expiry",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12)),
                                      Text(controller.expiry.value,
                                          style: TextStyle(
                                              color: const Color.fromARGB(255, 242, 241, 241), fontSize: 12,fontWeight: FontWeight.bold)),
                                                               SizedBox(
                                    height:30, // 1% of screen height
                                  ),     
                                      Text("cvv",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14)),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                controller.showCVV.toggle(),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        controller.showCVV.value
                                                            ? controller.cvv.value
                                                            : "***",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                14)),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      controller.showCVV.value
                                                          ? Icons.visibility
                                                          : Icons.visibility_off,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.copy,
                                    color: Colors.red, size: 12),
                                SizedBox(width: screenWidth * 0.02),
                                Text("Copy Details",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:12)),
                              ],
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset("assets/images/rupay.png",
                                  width: iconSize * 1.5),
                            ),
                          ],
                        ))
                    : FadeInLeft
                    (
                      duration: Duration(seconds: 1),
                      child: Container(
                                              height: MediaQuery.of(context).size.height * 0.35, // 28% of screen height
                        width: MediaQuery.of(context).size.width * 0.4, 
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.grey[900]!, Colors.black]),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 53, 52, 52))),
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenWidth * 0.02),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: controller.isFrozen.value ? 0.1 : 1.0,
                              ),
                              SizedBox(height: screenWidth * 0.02),
                            ],
                          )),
                    )),
                Column(
                  children: [
                 Obx(()=>
                    Padding(
                         padding: const EdgeInsets.only(bottom: 60.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.isFrozen.toggle();
                        },
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(controller.isFrozen.value
                              ? "assets/images/fz.png"
                              : "assets/images/uz.png"),
                        ),
                      ),
                    ),
                
                
                 ),
                
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.08),
            Image.asset("assets/images/navi.png", width: screenWidth * 0.9),
          ],
        ),
      ),
    );
  }
}
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yolo_app/conroller/card_controller.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardController controller = Get.put(CardController());
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize = screenWidth * 0.05;

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black54, blurRadius: 30),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: 100,
            child: BottomAppBar(
              color: Color(0xFF0D0D0D),
              elevation: 0,
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
            child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    _buildNavItem(
      imagePath: 'assets/images/hm.png',
      label: "home",
      index: 0,
    ),
    _buildNavItem(
      imagePath: 'assets/images/qr.png',
      label: "yolo pay",
      index: 1,
      isCenter: true,
    ),
    _buildNavItem(
      imagePath: 'assets/images/tn.png',
      label: "ginie",
      index: 2,
    ),
  ],
),

            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF0D0D0D),
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            top: kIsWeb ? screenWidth * 0 : screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:kIsWeb? 40:50),
              Text("Select Payment Mode",
                  style: TextStyle(
                    fontSize: fontSize * 1.2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height:  10),
              Text("Choose your preferred payment method to \n make payment",
                  style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey)),
              SizedBox(height:  10),
              Row(
                children: [
                  Image.asset("assets/images/p.png", width: screenWidth * 0.3),
                  Image.asset("assets/images/c.png", width: screenWidth * 0.3),
                ],
              ),
              SizedBox(height:kIsWeb? 23:40),
              Text("YOUR DIGITAL DEBIT CARD",
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(198, 130, 126, 126),
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Obx(() => controller.isFrozen.value
                      ? Container(
                          height: 280,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.grey[900]!, Colors.black]),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 53, 52, 52))),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/yolo.png",
                                      width: 50),
                                  Image.asset("assets/images/yes.png", width: 50),
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
                                    children: controller.cardNumber.isNotEmpty
                                        ? controller.cardNumber
                                            .split(RegExp(r'\s|-'))
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  FadeInDown(
                                    duration: Duration(seconds: 1),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("expiry",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12)),
                                        Text(controller.expiry.value,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 242, 241, 241),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text("cvv",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
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
                                                              ? controller
                                                                  .cvv.value
                                                              : "***",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14)),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Icon(
                                                        controller.showCVV.value
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.red,
                                                        size: 20,
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
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(Icons.copy, color: Colors.red, size: 12),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text("Copy Details",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                ],
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset("assets/images/rupay.png",
                                    width: 50),
                              ),
                            ],
                          ))
                      : FadeInLeft(
                          duration: Duration(seconds: 1),
                          child: Container(
                             height: 280,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.grey[900]!, Colors.black]),
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 53, 52, 52))),
                              padding: EdgeInsets.all(screenWidth * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity:
                                        controller.isFrozen.value ? 0.1 : 1.0,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )),
                        )),
                  Column(
                    children: [
                      Obx(
                        () => Padding(
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
              SizedBox(height:  20),
            
            ],
          ),
        ),
      ),
    );
  }

Widget _buildNavItem({
  required String imagePath,
  required String label,
  required int index,
  bool isCenter = false,
}) {
  bool isSelected = selectedIndex == index;
  
  

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedIndex = index;

    
  

      });
    },
    
    child: Transform.translate(
      offset: isCenter ? Offset(0, -15) : Offset(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: isSelected
                ? BoxDecoration(
                  border:isCenter? Border():Border.all(color: !isSelected? const Color.fromARGB(255, 111, 110, 110):const Color.fromARGB(255, 193, 191, 191),),
                  borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2), // Soft white shadow
                        blurRadius: 50,
                        spreadRadius: 0.1,
                      ),
                    ],
                  )
                :BoxDecoration(
                  border:isCenter? Border():Border.all(color: isSelected?Colors.white: const Color.fromARGB(255, 111, 110, 110),),
                  borderRadius: BorderRadius.circular(50),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.white.withOpacity(0.2), // Soft white shadow
                    //     blurRadius: 50,
                    //     spreadRadius: 0.1,
                    //   ),
                    // ],
                  ), // No shadow for unselected items
            child: Image.asset(imagePath,  width: isCenter? 50:40, height:isCenter? 50:40),
          ),
          
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color.fromARGB(88, 158, 158, 158),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          
        ],
      ),
    ),
  );
  
}


}

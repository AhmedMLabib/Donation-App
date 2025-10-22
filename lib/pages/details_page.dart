import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/request_page.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key});
  final item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: Color.fromARGB(255, 99, 151, 110),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),

                child: Stack(
                  children: [
                    Image.asset(
                      item['mainPicture'] as String,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.only(top: 60),
                      width: double.infinity,
                      height: 100,

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 99, 151, 110),
                            Color.fromARGB(120, 99, 151, 110),

                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                shadowColor: Colors.black,
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            item["location"] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(item["date"], style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            Text(
                              item["userName"] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              item["isVerified"] ? "موثق" : "غير موثق",
                              style: TextStyle(
                                color: item["isVerified"]
                                    ? Color.fromARGB(255, 99, 151, 110)
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),

                      CircleAvatar(
                        backgroundImage: AssetImage(
                          item['userProfilePic'] as String,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                item["productName"] as String,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                item["description"] as String,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 99, 151, 110),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: userRole != "donor"
                    ? ElevatedButton(
                        onPressed: () => {
                          Get.to(RequestPage(), arguments: item),
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 99, 151, 110),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "أطلب",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : SizedBox(width: 0, height: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

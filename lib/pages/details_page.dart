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
            color: projectColors.mainColor,
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
                    Image.network(
                      item['item_image_url'] as String,
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
                            projectColors.mainColor,
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
                            item["usersData"]["user_address"] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item["created_at"].toString().substring(0, 10),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            Text(
                              item["usersData"]["user_name"] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              item["usersData"]["user_is_verfied"]
                                  ? "موثق"
                                  : "غير موثق",
                              style: TextStyle(
                                color: item["usersData"]["user_is_verfied"]
                                    ? projectColors.mainColor
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),

                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          item["usersData"]["user_image_url"] as String,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                item["item_name"] as String,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                item["item_description"] as String,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  color: projectColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: currentUser["user_role"] == "user"
                    ? ElevatedButton(
                        onPressed: () => {
                          Get.to(RequestPage(), arguments: item),
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: projectColors.mainColor,
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

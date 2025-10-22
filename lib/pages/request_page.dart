import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPage extends StatelessWidget {
  RequestPage({super.key});
  final item = Get.arguments;
  final reasonController = TextEditingController();
  final enableBtn = false.obs;
  sendRequest() {
    Get.snackbar("Reason", reasonController.text);
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                margin: EdgeInsets.only(bottom: 24),
                color: Colors.white60,
                elevation: 12,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            Text(item['location'] as String),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['userName'] as String,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    if (item['isVerified'] as bool) ...[
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.check_circle,
                                        color: Color.fromARGB(
                                          255,
                                          99,
                                          151,
                                          110,
                                        ),
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(item['date'] as String),
                              ],
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                item['userProfilePic'] as String,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text(
                          item['productName'] as String,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
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
                      SizedBox(height: 30),

                      TextField(
                        controller: reasonController,
                        textDirection: TextDirection.rtl,
                        maxLines: 4,
                        onChanged: (_) {
                          reasonController.text.isNotEmpty
                              ? enableBtn.value = true
                              : enableBtn.value = false;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: "سبب الطلب...",
                          hintTextDirection: TextDirection.rtl,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => ElevatedButton(
                          onPressed: enableBtn.value
                              ? () => sendRequest()
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 99, 151, 110),
                          ),
                          child: Text(
                            "أطلب",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

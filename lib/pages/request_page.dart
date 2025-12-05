import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/main.dart';
import 'package:sharek/services/request_serv.dart';

class RequestPage extends StatelessWidget {
  RequestPage({super.key});
  final item = Get.arguments;
  final reasonController = TextEditingController();
  final enableBtn = false.obs;
  final enableBtn1 = false.obs;
  final file = Rxn<File>();
  final isLoading = false.obs;

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
                            Text(item['usersData']["user_address"] as String),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['usersData']["user_name"] as String,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    if (item['usersData']["user_is_verfied"]
                                        as bool) ...[
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
                                Text(
                                  item['created_at'].toString().substring(
                                    0,
                                    10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                item['usersData']["user_image_url"] as String,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text(
                          item['item_name'] as String,
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
                      TextButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final result = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (result != null) {
                            file.value = File(result.path);
                            enableBtn1.value = true;
                          }
                        },
                        child: Text(
                          'مرفق صورة',
                          style: TextStyle(
                            color: projectColors.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => file.value != null
                            ? Image.file(file.value!, width: 150, height: 150)
                            : SizedBox.shrink(),
                      ),

                      Obx(
                        () => ElevatedButton(
                          onPressed:
                              enableBtn.value &
                                  enableBtn1.value &
                                  !isLoading.value
                              ? () async {
                                  isLoading.value = true;
                                  await RequestServ().sendRequest(
                                    item,
                                    reasonController.text.trim(),
                                    file,
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: projectColors.mainColor,
                          ),
                          child: isLoading.value
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                )
                              : Text(
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

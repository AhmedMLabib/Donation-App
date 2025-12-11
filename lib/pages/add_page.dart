import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharek/pages/main_screen.dart';
import 'package:sharek/services/home_serv.dart';
import 'package:sharek/services/utils.dart';

import '../main.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final nameCont = TextEditingController();
  final descriptionCont = TextEditingController();
  final isLoading = false.obs;
  final categories = [].obs;
  final categoriesMaps = [].obs;
  final file = Rxn<File>();

  final enableBtn1 = false.obs;
  final enableBtn2 = false.obs;
  final enableBtn3 = false.obs;
  String selectedCategory = "";

  final List<String> otherCategories = [];
  String? selectedOther;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final res = await HomeServ().loadDistinctCat();
    final catRes = res;
    categoriesMaps.assignAll(catRes);
    final List<String> catList = catRes
        .map<String>((e) => e["category"].toString())
        .toList();
    categories.assignAll(catList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "إضافة تبرع",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),

                        child: Obx(
                          () => file.value != null
                              ? Image.file(
                                  file.value!,
                                  width: double.infinity,
                                  height: 200,
                                )
                              : SizedBox(height: 200, width: double.infinity),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon:  Icon(Icons.add, color:Theme.of(context).colorScheme.onPrimary ),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameCont,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        enableBtn2.value = true;
                      }else{

                        enableBtn2.value = false;
                      }
                    },
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      label: Align(
                        alignment: Alignment.centerRight,
                        child: Text("الاسم", textDirection: TextDirection.rtl),
                      ),
                      hintText: "مثال: جاكيت",
                      hintTextDirection: TextDirection.rtl,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionCont,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        enableBtn3.value = true;
                      }else{

                        enableBtn3.value = false;
                      }
                    },
                    maxLines: 3,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      label: Align(
                        alignment: Alignment.centerRight,
                        child: Text("الوصف", textDirection: TextDirection.rtl),
                      ),
                      hintText: "القيمة",
                      hintTextDirection: TextDirection.rtl,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      children: categories.map((cat) {
                        final isSelected = selectedCategory == cat;
                        return ChoiceChip(
                          label: Text(cat, textDirection: TextDirection.rtl),
                          selected: isSelected,
                          onSelected: (val) {
                            setState(() {
                              selectedCategory = cat;
                              selectedOther = null;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (selectedCategory == "أخرى")
                    Wrap(
                      spacing: 8,
                      children: otherCategories.map((cat) {
                        final isSelected = selectedOther == cat;
                        return ChoiceChip(
                          label: Text(cat, textDirection: TextDirection.rtl),
                          selected: isSelected,
                          onSelected: (val) {
                            setState(() {
                              selectedOther = cat;
                            });
                          },
                          selectedColor: Colors.grey.shade400,
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            enableBtn1.value &&
                                enableBtn2.value &&
                                enableBtn3.value &&
                                selectedCategory.isNotEmpty
                            ? () async {
                                isLoading.value = true;
                                final url = await Utils().uploadImage(
                                  "item",
                                  file,
                                );
                                final int id =
                                    categoriesMaps.firstWhere(
                                          (e) =>
                                              e["category"] == selectedCategory,
                                          orElse: () => null,
                                        )?["category_id"]
                                        as int;

                                await cloud.from('items').insert({
                                  'item_name': nameCont.text,
                                  'item_description': descriptionCont.text,
                                  "item_image_url": url,
                                  "category_id": id,
                                  "donor_id": currentUser["user_id"],
                                });
                                Get.offAll(MainScreen());
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading.value
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context).colorScheme.surface,
                              )
                            : Text("إضافة"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

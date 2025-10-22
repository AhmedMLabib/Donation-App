import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notifications_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final nameCont = TextEditingController();
  final descriptionCont = TextEditingController();

  final List<String> categories = ["ملابس", "تكنولوجيا", "كتب", "أخرى"];
  String selectedCategory = "ملابس";

  final List<String> otherCategories = ["أثاث", "ألعاب", "أدوات", "طعام"];
  String? selectedOther;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: const Color.fromARGB(255, 99, 151, 110),
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
                  const Text(
                    "إضافة تبرع",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/laptop.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameCont,
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
                  Wrap(
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
                        selectedColor: const Color.fromARGB(255, 99, 151, 110),
                      );
                    }).toList(),
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
                    child: ElevatedButton(
                      onPressed: () {
                        String chosenCategory =
                            selectedCategory == "أخرى" && selectedOther != null
                            ? selectedOther!
                            : selectedCategory;

                        Get.snackbar(
                          "تم إضافة التبرع",
                          "الاسم: ${nameCont.text}, الفئة: $chosenCategory",
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(12),
                          duration: const Duration(seconds: 3),
                          titleText: const Text(
                            "تم إضافة التبرع",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          messageText: Text(
                            "الاسم: ${nameCont.text}, الفئة: $chosenCategory",
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      },
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
                      child: const Text("إضافة"),
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

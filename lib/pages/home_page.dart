import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/details_page.dart';
import 'package:sharek/pages/notifications_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final address = "الجيزة , مصر";
  final searchController = TextEditingController();

  final categories = ['ملابس', 'إلكترونيات', 'كتب', 'طعام', "ألعاب"];
  final mainItems = [
    {
      "mainPicture": "assets/images/laptop.jpg",
      "userName": "أحمد علي",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-26",
      "location": "القاهرة، مصر",
      "productName": "لاب توب",

      "category": "إلكترونيات",
      "description":
          "هذا وصف تفصيلي للاب توب. إنه جهاز قوي ومناسب لجميع احتياجاتك اليومية. يأتي بمعالج سريع وذاكرة كبيرة لتخزين جميع ملفاتك.",
    },
    {
      "mainPicture": "assets/images/toy.png",
      "userName": "محمد حسن",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-26",
      "location": "الشرقية، مصر",
      "productName": "لعبة أطفال",
      "category": "ألعاب",
      "description":
          "هذه لعبة أطفال ممتعة وآمنة. مصنوعة من مواد عالية الجودة وتساعد في تطوير مهارات الأطفال الحركية والإبداعية.",
    },
    {
      "mainPicture": "assets/images/book.jpg",
      "userName": "سارة محمد",
      "isVerified": false,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-20",
      "location": "الإسكندرية، مصر",
      "productName": "كتاب",
      "category": "كتب",
      "description":
          "هذا كتاب شيق يحتوي على معلومات قيمة في مجاله. مناسب لجميع الأعمار ويقدم محتوى مفيد وممتع للقراءة.",
    },
    {
      "mainPicture": "assets/images/t-shirt.jpg",
      "userName": "عمر خالد",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-15",
      "location": "الجيزة، مصر",
      "productName": "تي شيرت",
      "category": "ملابس",
      "description":
          "هذا تي شيرت مريح وعصري. مصنوع من قماش عالي الجودة ويوفر راحة طوال اليوم. مناسب لجميع المناسبات.",
    },
    {
      "mainPicture": "assets/images/food.jpg",
      "userName": "ليلى علي",
      "isVerified": false,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-10",
      "location": "المنصورة، مصر",
      "productName": "طعام",

      "category": "طعام",
      "description":
          "هذا الطعام لذيذ ومغذي. مصنوع من مكونات طازجة وصحية، ويوفر تجربة طعام ممتعة ومشبعة.",
    },
  ];
  // will remove to init state
  final items = [
    {
      "mainPicture": "assets/images/laptop.jpg",
      "userName": "أحمد علي",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-26",
      "location": "القاهرة، مصر",
      "productName": "لاب توب",
      "category": "إلكترونيات",
      "description":
          "هذا وصف تفصيلي للاب توب. إنه جهاز قوي ومناسب لجميع احتياجاتك اليومية. يأتي بمعالج سريع وذاكرة كبيرة لتخزين جميع ملفاتك.",
    },
    {
      "mainPicture": "assets/images/toy.png",
      "userName": "محمد حسن",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-26",
      "location": "الشرقية، مصر",
      "productName": "لعبة أطفال",
      "category": "ألعاب",
      "description":
          "هذه لعبة أطفال ممتعة وآمنة. مصنوعة من مواد عالية الجودة وتساعد في تطوير مهارات الأطفال الحركية والإبداعية.",
    },
    {
      "mainPicture": "assets/images/book.jpg",
      "userName": "سارة محمد",
      "isVerified": false,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-20",
      "location": "الإسكندرية، مصر",
      "productName": "كتاب",
      "category": "كتب",
      "description":
          "هذا كتاب شيق يحتوي على معلومات قيمة في مجاله. مناسب لجميع الأعمار ويقدم محتوى مفيد وممتع للقراءة.",
    },
    {
      "mainPicture": "assets/images/t-shirt.jpg",
      "userName": "عمر خالد",
      "isVerified": true,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-15",
      "location": "الجيزة، مصر",
      "productName": "تي شيرت",
      "category": "ملابس",
      "description":
          "هذا تي شيرت مريح وعصري. مصنوع من قماش عالي الجودة ويوفر راحة طوال اليوم. مناسب لجميع المناسبات.",
    },
    {
      "mainPicture": "assets/images/food.jpg",
      "userName": "ليلى علي",
      "isVerified": false,
      "userProfilePic": "assets/images/profile.png",
      "date": "2025-09-10",
      "location": "المنصورة، مصر",
      "productName": "طعام",
      "category": "طعام",
      "description":
          "هذا الطعام لذيذ ومغذي. مصنوع من مكونات طازجة وصحية، ويوفر تجربة طعام ممتعة ومشبعة.",
    },
  ].obs;

  void filterByCat(cat) {
    cat.isEmpty
        ? items.value = mainItems
        : items.value = mainItems
              .where(
                (item) =>
                    (item['category'] as String).toLowerCase().contains(cat),
              )
              .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.notifications_none_outlined, size: 35),
          onPressed: () {
            Get.to(NotificationsPage());
          },
        ),
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [Icon(Icons.location_on), Text(address)],
              ),
              // Search Bar
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,

                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 157, 192, 138),
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  hintText: 'أبحث',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search, size: 30, color: Colors.white),
                    onPressed: () {
                      final query = searchController.text.toLowerCase();
                      query.isEmpty
                          ? items.value = mainItems
                          : items.value = mainItems
                                .where(
                                  (item) => (item['productName'] as String)
                                      .toLowerCase()
                                      .contains(query),
                                )
                                .toList();
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Categories
              GridView.builder(
                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length > 4 ? 4 : categories.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 30,
                ),

                itemBuilder: (context, index) {
                  if (categories.length > 4 && index == 0) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "كل التصنيفات",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            mainAxisExtent: 40,
                                          ),
                                      itemCount: categories.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () =>
                                              filterByCat(categories[index]),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                99,
                                                151,
                                                110,
                                              ),

                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: Text(
                                              categories[index],
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 192, 138),
                          borderRadius: BorderRadius.circular(32),
                        ),

                        child: Text(
                          "...أخرى",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () => filterByCat(categories[index]),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 157, 192, 138),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 10),
              // Items
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      final item = items.value[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 24),
                        color: Colors.white60,
                        elevation: 12,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => DetailsPage(), arguments: item);
                          },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  bottom: 8,
                                ),
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
                            ],
                          ),
                        ),
                      );
                    
                    },
                    itemCount: items.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

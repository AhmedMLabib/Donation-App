import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/details_page.dart';
import 'package:sharek/pages/notifications_page.dart';

import '../services/home_serv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  final categories = [].obs;
  final items = [].obs;
  final mainItems = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final res = await HomeServ().loadData();
    final itemsRes = res[0];
    final catRes = res[1];
    if (itemsRes != mainItems) {
      mainItems.clear();
      mainItems.addAll(itemsRes);
      items.value = mainItems;
    }
    if (catRes != categories) {
      categories.clear();
      categories.addAll(catRes);
    }
  }

  void filterByCat(cat) {
    items.value = mainItems
        .where((item) => item['category_id'] == cat["category_id"])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 35,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            isLogin
                ? Get.to(NotificationsPage())
                : Get.snackbar("الاشعارات", "برجاء تسجيل الدخول اولا");
          },
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData();
        },
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              isLogin
                  ? Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Text(
                          currentUser["user_address"] as String,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              // Search Bar
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
                cursorColor: Theme.of(context).colorScheme.surface,
                onTapOutside: (event) {
                  if (searchController.text.isEmpty) {
                    items.value = mainItems;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: projectColors.secondaryColor,
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  hintText: 'أبحث',
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () {
                      final query = searchController.text.toLowerCase();
                      query.isEmpty
                          ? items.value = mainItems
                          : items.value = mainItems
                                .where(
                                  (item) => (item['item_name'] as String)
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
              Obx(
                () => categories.isNotEmpty
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: GridView.builder(
                          shrinkWrap: true,

                          physics: NeverScrollableScrollPhysics(),
                          itemCount: categories.length > 4
                              ? 4
                              : categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
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
                                                    onTap: () => filterByCat(
                                                      categories[index],
                                                    ),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(
                                                          context,
                                                        ).colorScheme.onPrimary,

                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              32,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        categories[index]["category"],
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.surface,
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
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(32),
                                  ),

                                  child: Text(
                                    "...أخرى",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Text(
                                  categories[index]["category"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
              ),

              SizedBox(height: 10),
              // Items
              Expanded(
                child: Obx(
                  () => items.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            final item = items.value[index];
                            return Card(
                              margin: EdgeInsets.only(bottom: 24),
                              color: Theme.of(context).colorScheme.secondary,
                              elevation: 12,
                              shadowColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
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
                                          Text(
                                            item['usersData']["user_address"]
                                                as String,
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    item['usersData']['user_name']
                                                        as String,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary,
                                                    ),
                                                  ),
                                                  if (item['usersData']['user_is_verfied']
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
                                                item['created_at']
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.onPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),

                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              item['usersData']['user_image_url']
                                                  as String,
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
                                        item['item_name'] as String,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
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
                                                  Color.fromARGB(
                                                    255,
                                                    99,
                                                    151,
                                                    110,
                                                  ),
                                                  Color.fromARGB(
                                                    120,
                                                    99,
                                                    151,
                                                    110,
                                                  ),

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
                        )
                      : Center(
                          child: Text(
                            "لا يوجد تبرعات لعرضها",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
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

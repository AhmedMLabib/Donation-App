import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/donation_requests.dart';
import 'package:sharek/services/items_serv.dart';
import 'package:sharek/widgets/request_donation_card.dart';

class MyDonationsPage extends StatefulWidget {
  const MyDonationsPage({super.key});

  @override
  State<MyDonationsPage> createState() => _MyDonationsPageState();
}

class _MyDonationsPageState extends State<MyDonationsPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final items = [].obs;
  loadData() async {
    final res = await ItemsServ().loadData();
    items.assignAll(res);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,

            title: const Text(
              'تبرعاتي',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Obx(
                () => items.value.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return InkWell(
                            onTap: () async {
                    Get.to(
                                DonationRequests(),
                                arguments: item,
                              );
                            },
                            child: RequestDonationCard(
                              imagePath: item['item_image_url'],
                              title: item['item_name'],
                              status: item["item_description"],
                              buttonText: 'حذف المنشور',
                              onButtonPressed: () {
                                ItemsServ()
                                    .deleteDonation(item)
                                    .then((success) {
                                      if (success) {
                                        items.removeAt(index);
                                      }
                                    });
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "لا يوجد تبرعات لعرضها",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
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

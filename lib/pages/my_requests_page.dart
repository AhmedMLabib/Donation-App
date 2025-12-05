import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/services/requests_serv.dart';
import 'package:sharek/widgets/request_donation_card.dart';

class MyRequestsPage extends StatefulWidget {
  MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  final requests = [].obs;
  loadData() async {
    final res = await RequestsServ().loadData();
    requests.assignAll(res);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'طلباتي',
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
              // التبويب الأول: طلبات غير مكتملة
              Obx(
                () => ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return RequestDonationCard(
                      imagePath: request['attachment'],
                      title: request['req_reason'],
                      status: request["status"],
                      buttonText: 'إلغاء الطلب',
                      onButtonPressed: () {
                        RequestsServ()
                            .deleteRequest(request['request_id'])
                            .then((success) {
                              if (success) {
                                requests.removeAt(index);
                              }
                            });
                      },
                    );
                  },
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

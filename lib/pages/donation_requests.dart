import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/services/items_serv.dart';

class DonationRequests extends StatefulWidget {
  DonationRequests({super.key});

  @override
  State<DonationRequests> createState() => _DonationRequestsState();
}

class _DonationRequestsState extends State<DonationRequests> {
  final item = Get.arguments;

  final requests = [].obs;
  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  loadRequests() async {
    final res = await ItemsServ().getDonationRequests(item["item_id"]);
    requests.assignAll(res);
    print("Loaded Requests: $res");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلبات التبرع')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
                () => ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Column(
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
                                request['attachment'] as String,
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
                          color: Theme.of(context).colorScheme.surface,
                          shadowColor: Theme.of(context).colorScheme.onPrimary,
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      request["recipient_id"]["user_address"]
                                          as String,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                    Text(
                                      request["created_at"]
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),

                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        request["recipient_id"]["user_name"]
                                            as String,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                      ),
                                      Text(
                                        request["recipient_id"]["user_is_verfied"]
                                            ? "موثق"
                                            : "غير موثق",
                                        style: TextStyle(
                                          color:
                                              request["recipient_id"]["user_is_verfied"]
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.onPrimary
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    request["recipient_id"]["user_image_url"]
                                        as String,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Text(
                          request["req_reason"] as String,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: request["status"] as String,
                          items: const [
                            DropdownMenuItem(
                              value: "pending",
                              child: Text("Pending"),
                            ),
                            DropdownMenuItem(
                              value: "finished",
                              child: Text("Finished"),
                            ),
                          ],
                          onChanged: (val) async {
                            if (val != null) {
                              final res = await ItemsServ().changeItemStatus(
                                val,
                                item,
                                request["recipient_id"]["user_id"],
                              );
                              requests[index]["status"] = res[0]["status"];
                              requests.refresh();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            
      ),
    );
  }
}

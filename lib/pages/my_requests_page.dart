import 'package:flutter/material.dart';
import 'package:sharek/widgets/request_donation_card.dart';

class MyRequestsPage extends StatelessWidget {
  const MyRequestsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
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
            bottom: const TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'طلبات غير مكتملة'),
                Tab(text: 'سجل طلباتي'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // التبويب الأول: طلبات غير مكتملة
              ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  RequestDonationCard(
                    imagePath: 'assets/images/book.png',
                    title:
                        'طلب مجموعة كتب إتقان الإنجليزية لتطوير مهاراتي اللغوية',
                    status: 'حالة الطلب: قيد المراجعة',
                    buttonText: 'إلغاء الطلب',
                    onButtonPressed: () {},
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/shirt.png',
                    title: 'طلب تيشرت رجالي مقاس 2X بلون أزرق بحالة ممتازة',
                    status: 'حالة الطلب: مقبول',
                    buttonText: 'تواصل مع المتبرع',
                    onButtonPressed: () {},
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/toy.png',
                    title: 'طلب لعبة أطفال آمنة ومناسبة لعمر 3 سنوات',
                    status: 'حالة الطلب: مرفوض',
                  ),
                ],
              ),
              // التبويب الثاني: سجل الطلبات
              ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  RequestDonationCard(
                    imagePath: 'assets/images/wheelchair.png',
                    title: 'طلب كرسي متحرك لاستخدامه بعد إصابة في القدم',
                    status: 'حالة الطلب: مكتمل',
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/bag.png',
                    title:
                        'طلب شنطة مدرسية بناتي مناسبة لطالبة في المرحلة الابتدائية',
                    status: 'حالة الطلب: مكتمل',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

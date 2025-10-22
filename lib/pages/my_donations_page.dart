import 'package:flutter/material.dart';
import 'package:sharek/widgets/request_donation_card.dart';

class MyDonationsPage extends StatelessWidget {
  const MyDonationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'تبرعاتي',
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
                Tab(text: 'تبرعات نشطة'),
                Tab(text: 'سجل تبرعاتي'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // التبويب الأول: التبرعات النشطة
              ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  RequestDonationCard(
                    imagePath: 'assets/images/book.png',
                    title:
                        'مجموعة كتب في تعلم اللغة الإنجليزية لمن يريد التعلم وغير قادر على شراء الكتب',
                    status: 'حالة التبرع: في انتظار مستفيد',
                    buttonText: 'حذف المنشور',
                    onButtonPressed: () {},
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/shirt.png',
                    title: 'تيشرت رجالي مقاس 2X بحالة ممتازة لمن يحتاجه',
                    status: 'حالة التبرع: 3 أشخاص قدموا طلب',
                    buttonText: 'تواصل مع المستفيد',
                    onButtonPressed: () {},
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/toy.png',
                    title:
                        'لعبة أطفال بلاستيكية آمنة على الطفل مناسبة لعمر 3 سنوات',
                    status: 'حالة التبرع: 1 شخص قدم طلب',
                    buttonText: 'تواصل مع المستفيد',
                    onButtonPressed: () {},
                  ),
                ],
              ),
              // التبويب الثاني: سجل التبرعات
              ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  RequestDonationCard(
                    imagePath: 'assets/images/wheelchair.png',
                    title:
                        'كرسي متحرك لذوي الاحتياجات الخاصة أو المصابين في القدم',
                    status: 'حالة التبرع: مكتمل',
                  ),
                  RequestDonationCard(
                    imagePath: 'assets/images/bag.png',
                    title: 'شنطة مدرسية بناتي مناسبة لطفلة 8 سنوات',
                    status: 'حالة التبرع: مكتمل',
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

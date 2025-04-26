import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'step10_success.dart';

class Step9PaymentGateway extends StatelessWidget {
  final String duration;
  final String deliveryTime;
  final DateTime startDate;
  final DateTime endDate;
  final bool skippingEnabled;
  final List<String> addOns;
  final Map<String, String> dailyMeals;
  final String couponCode;

  const Step9PaymentGateway({
    Key? key,
    required this.duration,
    required this.deliveryTime,
    required this.startDate,
    required this.endDate,
    required this.skippingEnabled,
    required this.addOns,
    required this.dailyMeals,
    required this.couponCode,
  }) : super(key: key);

  int getBasePrice() {
    if (duration.contains('7')) return 699;
    if (duration.contains('15')) return 1349;
    if (duration.contains('30')) return 2499;
    return 0;
  }

  int getAddOnPrice() {
    int days = endDate.difference(startDate).inDays + 1;
    int total = 0;
    if (addOns.contains('Salad')) total += 10 * days;
    if (addOns.contains('Curd')) total += 15 * days;
    if (addOns.contains('Sweet')) total += 20 * days;
    return total;
  }

  int getDiscount() {
    if (couponCode.toLowerCase() == "SAVE50") return 50;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd MMM yyyy');
    int base = getBasePrice();
    int addons = getAddOnPrice();
    int discount = getDiscount();
    int total = base + addons - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Base Plan Price: ₹$base"),
            Text("Add-ons Price: ₹$addons"),
            Text("Discount: -₹$discount"),
            const Divider(),
            Text("Total: ₹$total", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text("Payment Options", style: TextStyle(fontWeight: FontWeight.bold)),
            const ListTile(leading: Icon(Icons.account_balance_wallet), title: Text("Wallet / UPI")),
            const ListTile(leading: Icon(Icons.credit_card), title: Text("Credit / Debit Card")),
            const ListTile(leading: Icon(Icons.payments), title: Text("Razorpay / Paytm")),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Step10Success(
                        planName: duration,
                        nextDelivery: startDate.add(const Duration(days: 1)),
                      ),
                    ),
                  );
                },
                child: const Text("Pay Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

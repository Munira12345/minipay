import 'package:flutter/material.dart';
import '../../services/payment_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}


class _PaymentsScreenState extends State<PaymentsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitPayment() async {
    setState(() => _isLoading = true);

    final success = await PaymentService.submitPayment(
      name: _nameController.text,
      cardNumber: _cardNumberController.text,
      expiry: _expiryController.text,
      cvv: _cvvController.text,
    );

    setState(() => _isLoading = false);

    if (success) {
      // Show success notification
      await showSuccessNotification();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment submitted successfully!")),
      );
    } else {
      // Show failure message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit payment.")),
      );
    }
  }

  Future<void> showSuccessNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'payment_channel_id',
      'Payments',
      channelDescription: 'Notifications for payment status',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);


    await flutterLocalNotificationsPlugin.show(
      0,
      'Payment Successful',
      'Your transaction has been processed.',
      platformDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF1565C0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text("Checkout",
                    style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Payment Card",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),

              // Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("John Doe",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 10),
                    Text("1234 5678 9012 3456",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2.0)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("VISA",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("VALID THRU: 12/25",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Inputs
              _UnderlinedInput(label: "Name", controller: _nameController),
              _UnderlinedInput(
                  label: "Card Number", controller: _cardNumberController),
              _UnderlinedInput(
                  label: "Expiry Date", controller: _expiryController),
              _UnderlinedInput(label: "CVV", controller: _cvvController),

              const Spacer(),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                      : const Text("Confirm Payment",
                      style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnderlinedInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _UnderlinedInput({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            isDense: true,
            border: UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

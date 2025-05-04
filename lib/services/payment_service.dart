import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<bool> submitPayment({
    required String name,
    required String cardNumber,
    required String expiry,
    required String cvv,
  }) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");


    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "card_number": cardNumber,
        "expiry_date": expiry,
        "cvv": cvv,
      }),
    );

    return response.statusCode == 201;
  }
}

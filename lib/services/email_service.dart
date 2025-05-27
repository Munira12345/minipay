import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static Future<bool> sendEmailNotification({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    const serviceId = 'service_t65wqx6';
    const templateId = 'template_nyog9nr';
    const userId = '9RMEMhl9XIhHRsimk';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_email': toEmail,
          'subject': subject,
          'message': body,
        }
      }),
    );

    return response.statusCode == 200;
  }
}

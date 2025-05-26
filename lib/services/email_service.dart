import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static Future<bool> sendEmailNotification({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    const serviceId = 'service_acuakyl';
    const templateId = 'your_template_id';
    const userId = 'your_public_key';

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

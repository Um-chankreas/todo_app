import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/app/enum/return_msg.dart';
import 'package:todo_app/app/enum/status_msg.dart';
import 'package:todo_app/app/utils/app_log.dart';

class ApiService {
  static Future<ReturnMsg> requestApi(
    String url, {
    String type = 'POST',
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    AppLog.info("url: $url, type: $type");

    try {
      // Default headers
      final defaultHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };

      final mergedHeaders = {...defaultHeaders, ...?headers};
      http.Response response;

      switch (type.toUpperCase()) {
        case 'POST':
          response = await http.post(
            Uri.parse(url),
            headers: mergedHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
          break;

        case 'GET':
          response = await http.get(Uri.parse(url), headers: mergedHeaders);
          break;

        case 'PUT':
          response = await http.put(
            Uri.parse(url),
            headers: mergedHeaders,
            body: data != null ? jsonEncode(data) : null,
          );
          break;

        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: mergedHeaders);
          break;

        default:
          throw Exception("Unsupported request type: $type");
      }

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);

        if (res is Map<String, dynamic>) {
          if (res['status'] == 'failed' && res['session_status'] == 'closed') {
            return ReturnMsg(
              status: ResponseMsg.failed,
              message: "session expired!",
            );
          } else {
            return ReturnMsg.responses(res);
          }
        } else {
          return ReturnMsg.responses(res);
        }
      } else {
        return ReturnMsg(
          status: ResponseMsg.failed,
          message: 'Code[${response.statusCode}] cannot request',
        );
      }
    } catch (ex) {
      return ReturnMsg(status: ResponseMsg.failed, message: ex.toString());
    }
  }
}

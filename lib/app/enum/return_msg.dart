import 'package:todo_app/app/enum/status_msg.dart';

class ReturnMsg {
  ResponseMsg status;
  String message;
  dynamic object;

  ReturnMsg({required this.status, required this.message, this.object});

  static ReturnMsg responses(dynamic resp) {
    ResponseMsg status = ResponseMsg.failed;
    if (resp['code'] == 200 || resp['status'] == "Ok") {
      status = ResponseMsg.success;
    } else if (resp['code'] == 404) {
      status = ResponseMsg.failed;
    } else if (resp['status'] == "OK") {
      status = ResponseMsg.success;
    }
    return ReturnMsg(
      status: status,
      message: resp['message'].toString(),
      object: resp,
    );
  }
}

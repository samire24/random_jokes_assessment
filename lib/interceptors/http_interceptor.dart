import 'package:http_interceptor/http_interceptor.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers['Content-Type'] = "application/json-patch+json";
    data.headers['accept'] = "application/json";
    data.headers['x-api-key'] = "QUtFhHPnlQ5f13LDVpQL3a54XgQzTlCJa1PMSB3o";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    return data;
  }
}

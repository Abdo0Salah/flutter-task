import 'package:dio/dio.dart';

import '../../cache/cache_helper.dart';
import 'end_ponits.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    super.onRequest(options, handler);
  }
}

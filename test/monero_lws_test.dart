import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:monero_lws_dart/monero_lws_dart.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

void main() {
  test('gets address information', () async {
    final adapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    final dio = Dio(BaseOptions(validateStatus: (status) => true));
    dio.httpClientAdapter = adapter;

    MoneroLightweightWalletServiceClient client =
        MoneroLightweightWalletServiceClient(
          lwsDaemonAddress: "https://127.0.0.1:8443",
          dio: dio,
        );

    print("Invoking test 1");
    try {
      Response addressInfo = await client.get_address_info(
        "43zxvpcj5Xv9SEkNXbMCG7LPQStHMpFCQCmkmR4u5nzjWwq5Xkv5VmGgYEsHXg4ja2FGRD5wMWbBVMijDTqmmVqm93wHGkg",
        "7bea1907940afdd480eff7c4bcadb478a0fbb626df9e3ed74ae801e18f53e104",
      );
      print("Response status: ${addressInfo.statusCode}");
      print("Response data: ${addressInfo.data}");
    } catch (e) {
      print("Full error: $e");
      rethrow;
    }
  });
}

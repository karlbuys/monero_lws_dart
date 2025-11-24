import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// Get the deno tool at https://github.com/cake-tech/lws-interface-cli-deno.git
final dio = Dio();

// Configure Dio to ignore bad certificates
Dio createDio({required String baseUrl, bool trustSelfSigned = false}) {
  // initialize dio
  final dio = Dio()..options.baseUrl = baseUrl;
  // allow self-signed certificate
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => trustSelfSigned;
    return client;
  };
  return dio;
}

// A basic implementation of a Monero LWS client in Dart
// Technically, addresses and viewkeys aren't strings, but let's go with
// String for a first pass
class MoneroLightweightWalletServiceClient {
  String? lwsDaemonAddress;
  Dio dio;
  // Address is actually base58-address I think?
  MoneroLightweightWalletServiceClient({Dio? dio, String? lwsDaemonAddress})
    : lwsDaemonAddress = lwsDaemonAddress ?? "https://127.0.0.1:8443",
      dio = dio ?? Dio();

  // deno run --unsafely-ignore-certificate-errors --allow-net index.js --host https://127.0.0.1:8443 login --address 43zxvpcj5Xv9SEkNXbMCG7LPQStHMpFCQCmkmR4u5nzjWwq5Xkv5VmGgYEsHXg4ja2FGRD5wMWbBVMijDTqmmVqm93wHGkg --view_key 7bea1907940afdd480eff7c4bcadb478a0fbb626df9e3ed74ae801e18f53e104 --
  // Future<Map<String, dynamic>> login(
  //   String address,
  //   String viewKey,
  //   String create_account,
  //   String generated_locally,
  // ) async {
  //   Response response;
  //   String Uri = "${lwsDaemonAddress}/login";
  //   response = await dio.post(
  //     Uri,
  //     data: {
  //       'address': address,
  //       'view_key': viewKey,
  //       'create_account': true,
  //       'generated_locally': true,
  //     },
  //   );

  //   // Now I need to use dio to craft a request to send to 127.0.0.1
  // }

  // Sends a request to a LWS wallet to scan our address using our public spend key.
  // import_wallet_request(String address, String viewKey) async {

  // }

  // Returns the minimal set of information needed to calculate a wallet balance.
  // The server cannot calculate when a spend occurs without the spend key,
  // so a list of candidate spends is returned.
  // Technically, these aren't strings, but let's go with String for a first pass
  // deno run --unsafely-ignore-certificate-errors --allow-net index.js --host https://127.0.0.1:8443 get_address_info --address 43zxvpcj5Xv9SEkNXbMCG7LPQStHMpFCQCmkmR4u5nzjWwq5Xkv5VmGgYEsHXg4ja2FGRD5wMWbBVMijDTqmmVqm93wHGkg --view_key 7bea1907940afdd480eff7c4bcadb478a0fbb626df9e3ed74ae801e18f53e104
  // DANGER: TLS certificate validation is disabled for all hostnames
  // {
  //   "locked_funds": "0",
  //   "total_received": "0",
  //   "total_sent": "0",
  //   "scanned_height": 3545781,
  //   "scanned_block_height": 3545781,
  //   "start_height": 3542413,
  //   "transaction_height": 3548229,
  //   "blockchain_height": 3548229
  // }
  Future<Response> get_address_info(String address, String viewKey) async {
    Response response;
    String Uri = "${this.lwsDaemonAddress}/get_address_info";
    try {
      response = await dio.post(
        Uri,
        data: {'address': address, 'view_key': viewKey},
      );
      return response;
    } on DioException catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  /* 
  Returns information needed to show transaction history. 
  
  The server cannot calculate when a spend occurs without the spend key, 
  so a list of candidate spends is returned. 

  We will obviously need to do that specific calculation ourselves.
  */
  get_address_txs(address, viewKey) async {
    Response response;
    String Uri = "${this.lwsDaemonAddress}/get_address_txs";
    try {
      response = await dio.post(
        Uri,
        data: {'address': address, 'view_key': viewKey},
      );
    } on DioException catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  /* Selects random outputs to use in a ring signature of a new transaction. */
  Future<Response> get_random_outs(String address, String viewKey) async {
    Response response;
    String Uri = "${this.lwsDaemonAddress}/get_random_outs";
    try {
      response = await dio.post(
        Uri,
        data: {'address': address, 'view_key': viewKey},
      );
      return response;
    } on DioException catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // /* Returns a list of outputs that are received outputs.
  //  * We need to determine cliesnt-side determine when the output was actually spent, since LWS
  //  * won’t be able to calculate which have been spent with only an address and a viewkey
  //  *
  // */
  get_unspent_outs(address, viewKey) {}

  // submit_raw_tx(address, viewKey, rawTx) {}
}

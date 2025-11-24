import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:monero_lws_dart/monero_lws_dart.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// Empty keys:
//
//
//
// Populated keys:
// '7bea1907940afdd480eff7c4bcadb478a0fbb626df9e3ed74ae801e18f53e104',
// '43zxvpcj5Xv9SEkNXbMCG7LPQStHMpFCQCmkmR4u5nzjWwq5Xkv5VmGgYEsHXg4ja2FGRD5wMWbBVMijDTqmmVqm93wHGkg',

void main() {
  test('gets unspent outs', () async {
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

    try {
      Response addressInfo = await client.get_address_info(
        "43zxvpcj5Xv9SEkNXbMCG7LPQStHMpFCQCmkmR4u5nzjWwq5Xkv5VmGgYEsHXg4ja2FGRD5wMWbBVMijDTqmmVqm93wHGkg",
        "7bea1907940afdd480eff7c4bcadb478a0fbb626df9e3ed74ae801e18f53e104",
      );
      print("Response status: ${addressInfo.statusCode}");
      print("Response data: ${addressInfo.data}");
    } catch (e) {
      print("Response data: ${e}");
    }
  });

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

// Get unspent outs
// 'amount': '4915189341745',
//       'outputs': [
//         {
//           'amount': '400000000000',
//           'public_key': 'cfdbedf495dc30be82d4934b72af8b1af98b4a35faf984f2c16e4866f45330ae',
//           'index': 0,
//           'global_index': 660333,
//           'rct': '40dd3f5c6c1ff8fe353cb08881c182c29ff7d9ab0055ef36f54514db7e894ef17b1117f21a7ec92dae74f07a6dfdf791eb6d8946615c16ea38ab5a0fb0538d056eb5f5bcd5cccb8b91744845d4f3486eaa9e7d9d2ac51f7364628abf44150100',
//           'tx_id': 2455631,
//           'tx_hash': '354d9874b7b13befcf8f079520ad72b78dc62de6081765ce5490345c7623d41a',
//           'tx_pub_key': 'fc7f85bf64c6e4f6aa612dbc8ddb1bb77a9283656e9c2b9e777c9519798622b2',
//           'tx_prefix_hash': '4448cbd20af2f4f14286707cc35b742e5eaf184037317017794d003457d720e2',
//           'spend_key_images': [
//             'ae30ee23051dc0bdf10303fbd3b7d8035a958079eb66516b1740f2c9b02c804e',
//             '3eb5bdbf119de8b0fea2b52e2c63ebfd2be152713326f7e0acb9c996a9007611',
//             '3c8ee840913cb4163f5b705aeb1da0b9b234be67cb61abf21c6648f40964479f',
//             '72fb0972751bfbcdd3ba62114d4371a25d54cf0e4c6c8ecb5bc0e3af1fafadab',
//             '810aca616598c564ca856330a3677592a5390bdddadf3e82d1563731dd2eef3c',
//             '423b9e89ed014f453eed8e914d7d8e77ca9f75805e5251750c35b09120b38755',
//             'dde80dee4ed041ffc2d85c020509fbd568e0ce440b9a12a3268ffe5490d027f8',
//             'f8bea7ac0b6777eb5c2db3574ee231cfaf5edbc590b4b3c98ccad5526b1312b7'
//           ],
//           'height': 1293044,
//           'timestamp': '2021-08-12T13:24:59Z'
//         },
//         {
//           'amount': '364000000000',
//           'public_key': '583ee3787e11559d0440a2edbdc8ec993f68913a234875d2df401f7726c1dad5',
//           'index': 1,
//           'global_index': 664673,
//           'rct': '98caf1149c4bfdac3603df8649721074aeb36d072a78dedc00c23ad9037ff4b89716ecc91c27637dde21492c6820dbbd4d7be5cc6a1e0ddbb6750a6802f042083f5ebc5807837be21951cf833674a7ea8896661cf6eaa45c0736ffc5fb88fd0a',
//           'tx_id': 2457238,
//           'tx_hash': 'a727cbcf59cc35f07066b314b53bc6239c4129f60e9ba1c7a8d5591b7a0b3055',
//           'tx_pub_key': '74b6ba3dd36a85e6e9b5fe4fc093c1e57ec0dc52cbac5e487a2b7a8da091893d',
//           'tx_prefix_hash': 'e6d3a3cf89fa01b093abaeff0085919331ca9cfdadeccfa58ed0d8de528b29ae',
//           'spend_key_images': [
//             '673ca2516ebb41d612692f3223c367457f685e92c3b6556b28630f9231bf5f54',
//             '169baea6bc976ef3bd689e8e810d5d33ca80e2cea6ef28903db324b975a2156b',
//             'e848a44a4aefea9d0870bc96d87707e0bf123f311682f252481bbe553e1a91ed',
//             '5ddeb3b324094dec2a7ad6091937370c847c870c9abd730ee86062f8a4a93b24',
//             '033f1c75e5c5682725f392dc722a14aa28aa6bb05823277065a09e4dd5005881',
//             'dbb8e201a3635adf1cddfcd7053eb4d5c3e38afbb41f6cd1311bcf98adda1700'
//           ],
//           'height': 1293420,
//           'timestamp': '2021-08-12T13:24:59Z'
//         }
//       ],
//       'per_byte_fee': 6040,
//       'fee_mask': 10000,
//       'fork_version': 14

// Get address txs
// {
//   transactions: [
//     {
//       hash: '42867117f6623ddad4684f2f94ffdea253925e40a5d30d1ca641c2b45989807e',
//       id: 17862904,
//       timestamp: '2021-08-03T10:58:23Z',
//       total_received: '10000000000',
//       total_sent: '0',
//       unlock_time: 0,
//       height: 2418951,
//       coinbase: false,
//       mempool: false,
//       mixin: 10
//     },
//     {
//       hash: 'ed71881597535d09ad9e73a5889aa2130137560566f87de1b5b7c2f25358ae3b',
//       id: 17864289,
//       timestamp: '2021-08-03T11:54:47Z',
//       total_received: '0',
//       total_sent: '10000000000',
//       fee: '70095000',
//       unlock_time: 0,
//       height: 2418982,
//       coinbase: false,
//       mempool: false,
//       mixin: 10,
//       spent_outputs: []
//     }
//   ],
//   start_height: 17862374,
//   scanned_height: 17864912,
//   blockchain_height: 2418990,
//   scanned_block_height: 2418990,
//   transaction_height: 17864912,
//   scanned_height: 17864912
// })

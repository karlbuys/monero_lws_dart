import 'dart:isolate';
import 'package:dio/dio.dart';

// Get the deno tool at https://github.com/cake-tech/lws-interface-cli-deno.git

// A basic implementation of a Monero LWS client in Dart
// Technically, addresses and viewkeys aren't strings, but let's go with
// String for a first pass
class MoneroLightweightWalletServiceClient {
  final lwsDaemonAddress = "https://127.0.0.1:8443";
  final dio = Dio();
  // Address is actually base58-address I think?
  login(
    String address,
    String viewKey,
    String create_account,
    String generated_locally,
  ) {
    // Now I need to use dio to craft a request to send to 127.0.0.1
  }

  // Sends a request to a LWS wallet to scan our address using our public spend key.
  import_wallet_request(String address, String viewKey) {}

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
  get_address_info(String address, String viewKey) async {
    Response response;
    response = await dio.post(
      this.lwsDaemonAddress,
      data: {'address': address, 'view_key': viewKey},
    );
  }

  /* 
  Returns information needed to show transaction history. 
  
  The server cannot calculate when a spend occurs without the spend key, 
  so a list of candidate spends is returned. 

  We will obviously need to do that specific calculation ourselves.
  */
  get_address_txs(address, viewKey) {}

  /* Selects random outputs to use in a ring signature of a new transaction. */
  get_random_outs(address, viewKey) {}

  /* Returns a list of received outputs. 
   * The client must determine when the output was actually spent, since LWS 
   * won’t be able to calculate which have been spent with only an address and a viewkey
   *   
  */
  get_unspent_outs(address, viewKey) {}

  submit_raw_tx(address, viewKey, rawTx) {}
}

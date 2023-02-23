import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';

class SSLPinning {
  static http.Client? _clientInstance;

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<http.Client> get _instance async =>
      _clientInstance ??= await _getIOClient();

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<SecurityContext> get _globalContext async {
    final sslCert =
        await rootBundle.load('certificates/themoviedb_certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> _getIOClient() async {
    HttpClient client = HttpClient(context: await _globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}

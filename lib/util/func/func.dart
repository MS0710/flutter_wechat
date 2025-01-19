import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Func{
  static Future scan() async{
    final String qrCodeResult= await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", "取消", true, ScanMode.QR,);
    print("qrCodeResult::$qrCodeResult");
  }
}
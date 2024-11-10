import 'dart:typed_data';

import 'package:Trip/config/constant.dart';
import 'package:Trip/config/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../config/const_wodget/custom_scaffold.dart';
import '../../data/model/fee/fee_model.dart';

class PrintPage extends StatefulWidget {
  final FeeModel feeModel;

  const PrintPage({super.key, required this.feeModel});
  @override
  _MaterialUiPrinterDemoState createState() => _MaterialUiPrinterDemoState();
}

class _MaterialUiPrinterDemoState extends State<PrintPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _printMaterialUiAsImage() async {
    print("object");
    // Capture the widget as an image
    Uint8List? imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      // Print the image using SunmiPrinter
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.printImage(imageBytes);
      await SunmiPrinter.lineWrap(2);
      await SunmiPrinter.submitTransactionPrint();
      await SunmiPrinter.exitTransactionPrint(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('طباعة الفاتورة'),
      ),
      body: Localizations.override(
        context: context,
        locale: Locale("US"),
        child: Center(
          child: SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: InvoiceWidget2(
                feeModel: widget.feeModel,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _printMaterialUiAsImage,
        child: Icon(Icons.print),
      ),
    );
  }
}

class InvoiceWidget2 extends StatelessWidget {
  final FeeModel feeModel;

  const InvoiceWidget2({super.key, required this.feeModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0, // Approx 80mm
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
            'assets/images/print_logo.jpg',
            width: 50.0, // Approx 14mm
            height: 50.0,
          ),
          // Title
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            child: Text(
              'الشركة العامة لأدارة النقل الخاص',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          // Invoice Details Title
          Text(
            'تفاصيل الفاتورة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          // Invoice Details
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInvoiceRow(
                    'رقم الفاتورة', feeModel.invoiceNumber.toString()),
                _buildInvoiceRow('تاريخ الانشاء',
                    DateFormat("yyyy/MM/dd").format(feeModel.creationDate)),
                _buildInvoiceRow('الرقم', feeModel.number.toString()),
              ],
            ),
          ),
          // Plate Details Title
          Text(
            'تفاصيل اللوحة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          // Plate Details
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                // Left Section (Country Code)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  width: 30.0, // Approx 7mm
                  height: 80.0, // Approx 20mm
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('I'),
                      Text('R'),
                      Text('A'),
                      Text('Q'),
                    ],
                  ),
                ),
                // Right Section (Plate Details)
                Expanded(
                  child: Column(
                    children: [
                      // Upper part (Arabic and English Plate Numbers)
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _buildPlateRow(feeModel.plateCharacterName ?? "",
                                  feeModel.plateNumber.toString()),
                            ],
                          ),
                        ),
                      ),
                      // Lower part (Governorate and Type)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(feeModel.governorateName ?? ""),
                              Text(feeModel.plateTypeName ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Fine Details
          _buildSectionTitle('تفاصيل الغرامة'),
          _buildFineDetails(),
          // Payment Details

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'تتضاعف الغرامة بعد شهر من تاريخ الاصدار',
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(Insets.medium),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildPlateRow(String arabic, String english) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(arabic),
        Text(english),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildFineDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildInvoiceRow('سبب الغرامة', feeModel.feeFinesName ?? ""),
          _buildInvoiceRow('اسم الكراج', feeModel.garageName ?? ""),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Text('المبلغ', textAlign: TextAlign.right),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "${feeModel.amount.toString().addCommas()} دينار",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildInvoiceRow('مدفوعة', feeModel.isPaid ? "نعم" : "لا"),
          _buildInvoiceRow(
              'رقم الدفع', feeModel.paymentNumber?.toString() ?? ""),
          _buildInvoiceRow('تاريخ الدفع', '2024/25/2'),
          _buildInvoiceRow('اسم كراج الدفع', 'ألنهظة'),
        ],
      ),
    );
  }
}

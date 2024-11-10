import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/config/extension/string_extension.dart';
import 'package:Trip/controller/fee_controller.dart';
import 'package:Trip/main.dart';
import 'package:Trip/pages/print/print_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';

import 'package:intl/intl.dart';

import '../../config/const_wodget/custom_scaffold.dart';
import '../../config/const_wodget/hero_image_preview.dart';

class FeeDetailsPage extends StatefulWidget {
  FeeDetailsPage({super.key});

  @override
  State<FeeDetailsPage> createState() => _FeeDetailsPageState();
}

class _FeeDetailsPageState extends State<FeeDetailsPage> {
  bool loading = false;
  final FeesController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.feesModel.value == null || loading
          ? CustomScaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomScaffold(
              appBar: AppBar(
                title: Text("تفاصيل المخالفة"),
                centerTitle: true,
              ),
              body: Container(
                margin: EdgeInsets.all(Insets.medium),
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة المخالفة"),
                      Gap(10),
                      Container(
                        child: HeroImagePreview(
                            mainImagePath:
                                "https://garagat-api.digital-logic.tech/" +
                                    (controller.addFeesFormModel?.images
                                                .isNotEmpty ??
                                            false
                                        ? controller.addFeesFormModel?.images[0]
                                        : controller.feesModel.value!.images
                                                .isNotEmpty
                                            ? controller
                                                .feesModel.value!.images[0]
                                            : ""),
                            imagePaths: controller.addFeesFormModel?.images
                                    .map((e) =>
                                        "https://garagat-api.digital-logic.tech/" +
                                        e)
                                    .toList() ??
                                controller.feesModel.value!.images
                                    .map((e) =>
                                        "https://garagat-api.digital-logic.tech/" +
                                        e)
                                    .toList(),
                            heroTag: "kkk",
                            index: 0),
                        width: Get.width,
                        height: Get.height * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(Insets.large),
                        decoration: BoxDecoration(
                            color: Color(0xff2684FF),
                            borderRadius: BorderRadius.circular(Insets.small)),
                        width: Get.width,
                        child: Row(
                          children: [
                            DetailsWidget1(
                              title: "رقم الوصل",
                              value: controller.addFeesFormModel?.number
                                      .toString() ??
                                  controller.feesModel.value!.number.toString(),
                            ),
                            DetailsWidget1(
                              title: "تاريخ المخالفة",
                              value: DateFormat("yyyy/MM/dd")
                                  .format(DateTime.now()),
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          DetailsWidget2(
                            name: "رقم اللوحة",
                            value: controller.feesModel.value!.plateNumber ??
                                "لا يوجد",
                          ),
                          DetailsWidget2(
                            name: "المحافظة",
                            value: controller.feesModel.value != null
                                ? controller.feesModel.value!.governorateName ??
                                    "لا يوجد"
                                : controller.governorates
                                    .firstWhere((e) =>
                                        controller
                                            .addFeesFormModel!.governorateId ==
                                        e.id)
                                    .name,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DetailsWidget2(
                            name: "حرف اللوحة",
                            value: controller
                                    .feesModel.value?.plateCharacterName ??
                                "لا يوجد",
                          ),
                          DetailsWidget2(
                            name: "نوع اللوحة",
                            value: controller.feesModel.value?.plateTypeName ??
                                "لا يوجد",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DetailsWidget2(
                            name: "اسم الكراج",
                            value: prefs.getString("garageName") ?? "لا يوجد",
                          ),
                          DetailsWidget2(
                            name: "كراج الدفع",
                            value:
                                controller.feesModel.value?.garagePaymentName ??
                                    "لا يوجد",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DetailsWidget2(
                            name: "مدفوعة",
                            value: controller.feesModel.value?.isPaid ?? false
                                ? "نعم"
                                : "لا",
                          ),
                          DetailsWidget2(
                            name: "المبلغ",
                            value: (controller.feesModel.value?.amount ?? 0)
                                .toString()
                                .addCommas(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: Get.height * 0.1,
                padding: EdgeInsets.all(Insets.small),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomFillButton(
                        title: "طباعة",
                        backgroundColor: Color(0xff0071FF),
                        onTap: () async {
                          // await connectToUsbPrinter(devices.first);
                          // testPrinter();
                          Get.to(PrintPage(
                            feeModel: controller.feesModel.value!,
                          ));
                        },
                      ),
                    ),
                    Gap(Insets.small),
                    Expanded(
                      flex: 1,
                      child: CustomFillButton(
                        title: "دفع",
                        backgroundColor: Colors.grey,
                        onTap: () async {
                          // await connectToUsbPrinter(devices.first);
                          // testPrinter();
                          if (controller.feesModel.value != null)
                            controller.payFine(
                                controller.feesModel.value!.id, 6);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  var printerManager = PrinterManager.instance;

  var devices = [];

  // Scan for USB printers
  Future<void> scanForUsbPrinters() async {
    try {
      // Find printers
      PrinterManager.instance
          .discovery(type: PrinterType.usb) // Scan for USB printers
          .listen((device) {
        print("Device found: ${device.name}");
        devices.add(device);
      });
    } catch (e) {
      print("Error scanning for USB printers: $e");
    }
  }

  // Connect to a USB printer
  Future<void> connectToUsbPrinter(PrinterDevice selectedPrinter) async {
    try {
      await PrinterManager.instance.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(
          name: selectedPrinter.name,
          productId: selectedPrinter.productId,
          vendorId: selectedPrinter.vendorId,
        ),
      );
      print("Connected to ${selectedPrinter.name}");
    } catch (e) {
      print("Error connecting to USB printer: $e");
    }
  }
}

class DetailsWidget2 extends StatelessWidget {
  const DetailsWidget2({super.key, required this.name, required this.value});
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(Insets.medium),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Color(0xff2684FF).withOpacity(0.20),
                    borderRadius: BorderRadius.circular(12)),
                child: SvgPicture.asset("assets/icons/invoice.svg"),
              ),
            ),
            Gap(15),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(name, style: TextStyle(fontSize: 8)),
                  Text(
                    value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsWidget1 extends StatelessWidget {
  const DetailsWidget1({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: SvgPicture.asset("assets/icons/invoice.svg"),
              ),
            ),
            Gap(15),
            Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

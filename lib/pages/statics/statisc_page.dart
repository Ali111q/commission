import 'dart:math';

import 'package:Trip/config/constant.dart';
import 'package:Trip/config/extension/string_extension.dart';
import 'package:Trip/controller/fee_controller.dart';
import 'package:Trip/controller/statics_controller.dart';
import 'package:Trip/data/model/fee/fee_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../config/const_wodget/custom_scaffold.dart';
import '../fee_details/fee_details_page.dart';

class StaticsPage extends StatelessWidget {
  final List<Color> colors = []; // Define colors list
  StaticsPage({super.key});
  final StaticsController controller = Get.find();
  final FeesController feesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.statics.value == null
          ? CustomScaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('الاحصائيات'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CustomScaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('الاحصائيات'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(Insets.small),
                      padding: EdgeInsets.all(Insets.medium),
                      decoration: BoxDecoration(
                        color: Color(0xff2684FF).withOpacity(0.54),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width * 0.4,
                            height: Get.width * 0.4,
                            child: Stack(
                              children: [
                                PieChart(
                                  PieChartData(
                                    sections: [
                                      ...controller
                                          .statics.value!.violationCardAnalysis
                                          .map(
                                        (e) {
                                          var color = Color(
                                                  (Random().nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                              .withOpacity(1.0);
                                          colors.add(color); // Store the color
                                          return PieChartSectionData(
                                            value: e.amount /
                                                controller.statics.value!
                                                    .numberOfViolations,
                                            color: color,
                                            radius: 20,
                                            borderSide: BorderSide.none,
                                            showTitle: false,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .statics.value!.numberOfViolations
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xff324F5E),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(20),
                          // Add labels with colors below the pie chart
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildLabelsWithColors(
                                controller.statics.value!.violationCardAnalysis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: Get.width * 0.42,
                            margin: EdgeInsets.all(Insets.small),
                            padding: EdgeInsets.all(Insets.medium),
                            decoration: BoxDecoration(
                              color: Color(0xffE0EDFD),
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "المبلغ الكلي للغرامات المسجلة",
                                  style: TextStyle(
                                    color: Color(0xff211A13),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(3),
                                Text(
                                  controller.statics.value!.totalPrice
                                          .toString()
                                          .addCommas() +
                                      "IQD",
                                  style: TextStyle(
                                    color: Color(0xff033D88),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        width: Get.width * 0.1,
                                        height: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                            "assets/icons/trafic_light.svg")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Get.width * 0.42,
                            margin: EdgeInsets.all(Insets.small),
                            padding: EdgeInsets.all(Insets.medium),
                            decoration: BoxDecoration(
                              color: Color(0xffE0EDFD),
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "عدد الغرامات",
                                  style: TextStyle(
                                    color: Color(0xff211A13),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(3),
                                Text(
                                  controller.statics.value!.numberOfViolations
                                      .toString(),
                                  style: TextStyle(
                                    color: Color(0xff033D88),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(10),
                                Expanded(child: Container()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        width: Get.width * 0.1,
                                        height: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                            "assets/icons/trafic_light.svg")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("اخر المخالفات"),
                          TextButton(onPressed: () {}, child: Text("المزيد")),
                        ],
                      ),
                    ),
                    ...controller.statics.value!.lastViolations.map(
                      (e) => GestureDetector(
                        onTap: () {
                          feesController.setFeeModel(FeeModel(
                              id: e.id,
                              creationDate: e.creationDate,
                              number: e.number,
                              plateNumber: e.plateNumber,
                              governorateId: e.vehicleGovernorateId,
                              governorateName: e.vehicleGovernorateName,
                              plateCharacterId: e.plateNumber,
                              plateCharacterName: e.vehiclePlateCharacterName,
                              plateTypeId: e.vehiclePlateType,
                              plateTypeName: e.vehiclePlateType,
                              feeFinesId: e.feeFines.id,
                              feeFinesName: e.feeFines.name,
                              garageId: e.garageId,
                              garageName: e.garageName,
                              amount: e.amount,
                              isPaid: e.isPaid,
                              paymentNumber: e.paymentReceiptNumber,
                              paymentDate: e.paymentDate,
                              garagePaymentId: e.paymentGarageId,
                              garagePaymentName: e.paymentGarage,
                              invoiceNumber: e.invoiceNumber.toString(),
                              isDirect: e.isDirect,
                              images: e.images,
                              note: e.note,
                              lat: e.lat,
                              lng: e.lng,
                              violationLocation: null));
                          Get.to(FeeDetailsPage());
                        },
                        child: Container(
                          margin: EdgeInsets.all(Insets.small),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffB9B9B9)),
                              borderRadius:
                                  BorderRadius.circular(Insets.small)),
                          width: Get.width,
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                padding: EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                    color: Color(0xff2684FF).withOpacity(0.20),
                                    borderRadius: BorderRadius.circular(12)),
                                child: SvgPicture.asset(
                                    "assets/icons/invoice.svg"),
                              ),
                              Expanded(
                                child: _buildPropColumn(
                                    name: "رقم الوصل",
                                    value: e.number.toString()),
                              ),
                              Expanded(
                                child: _buildPropColumn(
                                    name: "نوع المخالفة",
                                    value: e.feeFines.name ?? "لا يوجد "),
                              ),
                              Expanded(
                                child: _buildPropColumn(
                                    name: "المبلغ",
                                    value: e.amount.toString().addCommas()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  List<Widget> _buildLabelsWithColors(List<dynamic> analysisData) {
    List<Widget> rows = [];
    for (int i = 0; i < analysisData.length; i += 2) {
      List<Widget> rowItems = [];
      if (i < analysisData.length) {
        rowItems.add(
          Expanded(
            flex: 10,
            child: Container(
              // width: Get.width * 0.4,
              child: StaticsLabelWithColor(
                label: analysisData[i].name, // Adjust as per your data
                color: colors[i],
              ),
            ),
          ),
        );
      }
      if (i + 1 < analysisData.length) {
        rowItems.add(
          Expanded(
            flex: 10,
            child: Container(
              // width: Get.width * 0.4,
              child: StaticsLabelWithColor(
                label: analysisData[i + 1].name, // Adjust as per your data
                color: colors[i + 1],
              ),
            ),
          ),
        );
      }

      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowItems,
      ));
    }
    return rows;
  }

  Column _buildPropColumn({required String name, required String value}) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Color(0xffB9B9B9),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        Text(value, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class StaticsLabelWithColor extends StatelessWidget {
  const StaticsLabelWithColor({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 20),
          Text(
            label,
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

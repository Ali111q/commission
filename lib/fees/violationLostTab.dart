import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/extension/string_extension.dart';
import 'package:Trip/pages/fee_details/direct_fee_page.dart';
import 'package:flutter/material.dart';

import '../config/const_wodget/paginated_list.dart';
import '../config/constant.dart';
import '../controller/fee_controller.dart';
import '../pages/fee_details/fee_details_page.dart';

class Violationlosttab extends StatelessWidget {
  Violationlosttab({super.key});

  RefreshController refreshController = RefreshController();
  FeesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.84,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: controller.fees.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('لا يوجد غرامات'),
                  Gap(Insets.small),
                  CustomFillButton(
                      title: 'تحديث',
                      onTap: () {
                        controller.getFees(1);
                      })
                ],
              ))
            : PaginatedList(
                data: controller.fees,
                refreshController: refreshController,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _buildListWidget(index),
                    separatorBuilder: (context, index) => Gap(Insets.small),
                    itemCount: controller.fees.length),
                controller: null,
                pages: controller.page,
                getData: controller.getFees,
                totalPage: controller.totalPage),
      ),
    );
  }

  GestureDetector _buildListWidget(int index) {
    return GestureDetector(
      onTap: () {
        controller.setFeeModel(controller.fees[index]);
        Get.to(FeeDetailsPage());
      },
      child: Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffB9B9B9)),
            borderRadius: BorderRadius.circular(Insets.small)),
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
              child: SvgPicture.asset("assets/icons/invoice.svg"),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "رقم الوصل",
                  value: controller.fees[index].number.toString()),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "نوع المخالفة",
                  value: controller.fees[index].feeFinesName ?? "لا يوجد "),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "المبلغ",
                  value: controller.fees[index].amount.toString().addCommas()),
            ),
          ],
        ),
      ),
    );
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

class DirectViolations extends StatelessWidget {
  DirectViolations({super.key});

  RefreshController refreshController = RefreshController();
  FeesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.8,
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: controller.directViolations.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('لا يوجد غرامات'),
                    Gap(Insets.small),
                    CustomFillButton(
                        title: 'تحديث',
                        onTap: () {
                          controller.getDirectViolations(1);
                        })
                  ],
                ))
              : PaginatedList(
                  data: controller.directViolations,
                  refreshController: refreshController,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => _buildListWidget(index),
                      separatorBuilder: (context, index) => Gap(Insets.small),
                      itemCount: controller.directViolations.length),
                  controller: controller,
                  pages: controller.directViolationPage,
                  getData: controller.getDirectViolations,
                  totalPage: controller.directViolationTotalPage),
        ),
      ),
    );
  }

  GestureDetector _buildListWidget(int index) {
    return GestureDetector(
      onTap: () {
        controller.setDirectViolationModel(controller.directViolations[index]);
        Get.to(DirectFeePage());
      },
      child: Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffB9B9B9)),
            borderRadius: BorderRadius.circular(Insets.small)),
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
              child: SvgPicture.asset("assets/icons/invoice.svg"),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "رقم الوصل",
                  value: controller.directViolations[index].number.toString()),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "نوع المخالفة",
                  value: controller.directViolations[index].feeFinesName ??
                      "لا يوجد "),
            ),
            Expanded(
              child: _buildPropColumn(
                  name: "المبلغ",
                  value: controller.directViolations[index].amount
                      .toString()
                      .addCommas()),
            ),
          ],
        ),
      ),
    );
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

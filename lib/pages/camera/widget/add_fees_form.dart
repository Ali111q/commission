import 'package:Trip/config/const_wodget/custom_fill_button.dart';
import 'package:Trip/config/const_wodget/custom_text_form_field.dart';
import 'package:Trip/config/const_wodget/dropdown.dart';
import 'package:Trip/config/validator/validators.dart';
import 'package:Trip/controller/fee_controller.dart';
import 'package:Trip/pages/registered_fee/registered_fee_page.dart';
import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import 'searchable_dropdown.dart';

class AddFeesForm extends StatefulWidget {
  AddFeesForm({
    super.key,
  });

  @override
  State<AddFeesForm> createState() => _AddFeesFormState();
}

class _AddFeesFormState extends State<AddFeesForm> {
  FeesController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getLastNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Insets.small),
      child: Obx(
        () => Form(
          key: controller.formKey,
          child: Column(
            children: [
              Gap(10),
              CustomTextFormField(
                validators: [
                  IsRequiredRule(),
                ],
                hint: "الرقم",
                controller: controller.numberController,
              ),
              Gap(10),

              SearchableDropdown(
                hintText: 'المحافظة',
                items: [...controller.governorates.map((e) => e.name).toList()]
                    .obs,
                selectedItem: controller.selectedGovernorate.value?.name,
                onChanged: (value) {
                  var selected = controller.governorates
                      .firstWhere((e) => e.name == value);
                  controller.handleSelectGovernurate(selected.id);
                },
              ),

              Gap(10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: SearchableDropdown(
                          onSearch: (p0) {
                            controller.getPlateCharacters(search: p0);
                            // controller.plateCharacterSearch.value = p0;
                          },
                          items: [
                            ...controller.plateCharecters.map((e) => e.name)
                          ].obs,
                          hintText: "الحرف",
                          selectedItem:
                              controller.selectedPlateCharacter.value?.name,
                          onChanged: (value) {
                            var selected = controller.plateCharecters
                                .firstWhere((e) => e.name == value);
                            controller.handleSelectPlateCharacter(selected.id);
                          })),
                  Gap(5),
                  Expanded(
                      flex: 3,
                      child: CustomTextFormField(
                        controller: controller.plateNumber,
                        isLabelVisible: false,
                        validators: [
                          IsRequiredRule(),
                        ],
                        hint: "رقم اللوحة",
                      ))
                ],
              ),
              Gap(10),
              SearchableDropdown(
                  hintText: 'اختر نوع المخالفة',
                  selectedItem: controller.selectedFeeType.value?.name,
                  items:
                      [...controller.feeTypes.map((e) => e.name).toList()].obs,
                  onChanged: (value) {
                    var selected =
                        controller.feeTypes.firstWhere((e) => e.name == value);
                    controller.handleSelectFeeType(selected.id);
                  }),
              Gap(10),
              SearchableDropdown(
                  hintText: 'اختر نوع اللوحة',
                  selectedItem: controller.selectedPlateCarType.value?.name,
                  items: [
                    ...controller.plateCarTypeModels.map((e) => e.name).toList()
                  ].obs,
                  onChanged: (value) {
                    var selected = controller.plateCarTypeModels
                        .firstWhere((e) => e.name == value);
                    controller.handleSelectPlateCarType(selected.id);
                  }),

              Gap(10),
              CustomTextFormField(
                controller: controller.notes,
                isLabelVisible: false,
                validators: [],
                hint: "اكتب ملاحظاتك",
                maxLines: 5,
              ),
              Gap(10),
              // Expanded(child: Container()),
              CustomFillButton(
                isLoading: controller.loading.value,
                title: 'ارسال المخالفة',
                onTap: () {
                  // if (controller.loading.value) {
                  //   return;
                  // }
                  // Get.off(RegisteredTicketPage());
                  controller.addFees();
                },
              ),

              Gap(10),
            ],
          ),
        ),
      ),
      // child: Image.file(File(value.path)),
    );
  }
}

import 'package:Trip/config/const_wodget/paginated_list.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/config/extension/string_extension.dart';
import 'package:Trip/controller/fee_controller.dart';
import 'package:Trip/data/model/fee/fee_model.dart';
import 'package:Trip/fees/violationLostTab.dart';
import 'package:Trip/pages/fee_details/fee_details_page.dart';
import 'package:flutter/material.dart';

import '../config/const_wodget/custom_scaffold.dart';

class FeesPage extends StatefulWidget {
  FeesPage({super.key});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    // Listen to the TabController animation to track swiping progress
    tabController.animation?.addListener(() {
      setState(() {});
    });
  }

  // A method to interpolate between two colors based on the animation value
  Color interpolateColor(double position, Color startColor, Color endColor) {
    return Color.lerp(startColor, endColor, position)!;
  }

  @override
  Widget build(BuildContext context) {
    double animationValue = tabController.animation?.value ?? 0.0;

    // Calculate the color for each tab label based on the swipe position
    Color firstTabColor = interpolateColor(
      (1 - animationValue).clamp(0.0, 1.0),
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.background,
    );
    Color secondTabColor = interpolateColor(
      animationValue.clamp(0.0, 1.0),
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.background,
    );

    return CustomScaffold(
      appBar: AppBar(
        title: Text("سجل المخالفات"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24 + 12),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.2), // Background color with opacity
              borderRadius: BorderRadius.circular(
                  80), // Optional: Add border radius to match the shape
            ),
            child: TabBar(
              controller: tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).colorScheme.background,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Keep indicator color if needed
              ),
              unselectedLabelColor: context.theme.colorScheme.primary,
              labelPadding: EdgeInsets.all(10),
              indicatorWeight: 0,
              isScrollable: false,
              splashBorderRadius: BorderRadius.circular(Insets.medium - 10),
              splashFactory: NoSplash.splashFactory,
              labelStyle: context.textTheme.displaySmall!,
              onTap: (index) {
                setState(() {});
              },
              tabs: [
                Tab(
                  height: Insets.exLarge,
                  child: Text(
                    'الغرامات',
                    style: context.theme.textTheme.titleSmall!.copyWith(
                      color: firstTabColor, // Apply interpolated color
                    ),
                  ),
                ),
                Tab(
                  height: Insets.large,
                  child: Text(
                    'الغرامات المباشرة',
                    style: context.theme.textTheme.titleSmall!.copyWith(
                      color: secondTabColor, // Apply interpolated color
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(Insets.medium),
          Container(
            height: MediaQuery.of(context).size.height * 0.72,
            child: TabBarView(
              controller: tabController,
              children: [
                Violationlosttab(),
                DirectViolations(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

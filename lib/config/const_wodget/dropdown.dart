import 'package:Trip/config/constant.dart';
import 'package:Trip/config/extension/iterable_extension.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.title,
    this.onChanged,
    this.list,
    this.data,
    this.enabled,
    this.isSearch,
    this.value,
  });

  final List<String>? list;
  final List<T>? data;
  final String title;
  final bool? isSearch;
  final void Function(T?)? onChanged;
  final String? enabled;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      // enableFilter: true,
      enableSearch: isSearch == null ? true : false,
      onSelected: (value) {
        onChanged!(value);
        FocusScope.of(context).unfocus();
      },
      menuHeight: context.height * 0.3,
      menuStyle: MenuStyle(
        shadowColor: MaterialStateProperty.all(Colors.black),
        alignment: Alignment.bottomRight,
        surfaceTintColor: MaterialStateProperty.all(Colors.black),
        backgroundColor:
            MaterialStateProperty.all(context.theme.colorScheme.surface),
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.medium),
          ),
        ),
      ),

      expandedInsets: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Insets.large),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Insets.large),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Insets.large),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.small,
        ),
        hintStyle: context.textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      hintText: title,
      controller: TextEditingController(),
      initialSelection: value,

      requestFocusOnTap: true,

      // searchCallback: (entries, query) {
      //   if (query.isEmpty) {
      //     return null;
      //   }
      //   final int index = entries.indexWhere((entry) => entry.label == query);

      //   return index != -1 ? index : null;
      // },
      dropdownMenuEntries: data!.indexedMap((e, index) {
        return DropdownMenuEntry<T>(
          value: e,
          label: list == null
              ? ""
              : list!.isEmpty
                  ? ""
                  : list![index],
        );
      }).toList(),
    );
  }
}

// import 'package:Trip/config/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:Trip/config/constant.dart';
// import 'package:flutter/material.dart';

// class CustomDropDown extends StatelessWidget {
//   const CustomDropDown({
//     super.key,
//     required this.title,
//     this.onChanged,
//     this.list,
//     this.data,
//     this.enabled,
//     this.isSearch,
//     this.onSearchChanged,
//   });

//   final List<String>? list;
//   final List<Map<String, dynamic>>? data;
//   final String title;
//   final bool? isSearch;
//   final void Function(Object?)? onChanged;
//   final void Function(String)? onSearchChanged; // Callback for text changes
//   final String? enabled;

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController searchController = TextEditingController();

//     // Adding listener to searchController to call onSearchChanged when text changes
//     searchController.addListener(() {
//       if (onSearchChanged != null && searchController.text.isNotEmpty) {
//         onSearchChanged!(searchController.text);
//       }
//     });

//     return DropdownMenu(
//       enableSearch:
//           isSearch == true, // Enable or disable search based on isSearch flag
//       onSelected: (value) {
//         onChanged!(value);
//         FocusScope.of(context).unfocus();
//       },
//       menuHeight: context.height * 0.3,
//       menuStyle: MenuStyle(
//         shadowColor: MaterialStateProperty.all(Colors.black),
//         alignment: Alignment.bottomRight,
//         surfaceTintColor: MaterialStateProperty.all(Colors.black),
//         backgroundColor:
//             MaterialStateProperty.all(context.theme.colorScheme.surface),
//         elevation: MaterialStateProperty.all(2),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(Insets.medium),
//           ),
//         ),
//       ),
//       expandedInsets: const EdgeInsets.symmetric(
//         horizontal: 0,
//         vertical: 0,
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         fillColor: Theme.of(context).colorScheme.surface,
//         filled: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(Insets.large),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(Insets.large),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(Insets.large),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: Insets.medium,
//           vertical: Insets.small,
//         ),
//         hintStyle: context.textTheme.bodyMedium!.copyWith(
//           color: Theme.of(context).colorScheme.outline,
//         ),
//       ),
//       hintText: title,
//       controller:
//           searchController, // Use the controller for tracking text input
//       initialSelection: title,
//       requestFocusOnTap: true,
//       dropdownMenuEntries: data != null
//           ? data!.map((Map<String, dynamic> value) {
//               return DropdownMenuEntry(
//                 value: value,
//                 label: value['name'],
//                 enabled: enabled != value['name'],
//                 labelWidget: Text(
//                   value['name'],
//                 ),
//               );
//             }).toList()
//           : list!.map((String value) {
//               return DropdownMenuEntry(
//                 value: value,
//                 label: value,
//                 labelWidget: Text(value),
//               );
//             }).toList(),
//     );
//   }
// }

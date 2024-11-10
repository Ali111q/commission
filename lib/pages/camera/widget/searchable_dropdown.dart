import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../../../config/constant.dart';

class SearchableDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final Function(String)? onChanged;
  final double? borderRadius;
  final Function(String)? onSearch;

  const SearchableDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius,
    this.onSearch,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  String? selectedValue;
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
    filteredItems = widget.items;
  }

  void _onSearchChanged(String query) async {
    if (widget.onSearch != null) {
      await widget.onSearch!(query);
      setState(() {});
    } else {
      setState(() {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildMaterialDropdown();
  }

  Widget _buildCupertinoDropdown() {
    return GestureDetector(
      onTap: () {
        _showCupertinoPicker();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? widget.hintText,
              style: TextStyle(
                color: selectedValue == null
                    ? CupertinoColors.systemGrey
                    : CupertinoColors.black,
              ),
            ),
            const Icon(CupertinoIcons.arrow_down),
          ],
        ),
      ),
    );
  }

  void _showCupertinoPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.white,
          child: Column(
            children: [
              CupertinoTextField(
                controller: searchController,
                placeholder: "بحث...",
                onChanged: _onSearchChanged,
                padding: const EdgeInsets.all(16),
              ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: CupertinoColors.white,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: filteredItems
                        .indexOf(selectedValue ?? filteredItems[0]),
                  ),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedValue = filteredItems[index];
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(filteredItems[index]);
                    }
                  },
                  children: widget.items.map((item) => Text(item)).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaterialDropdown() {
    return GestureDetector(
      onTap: () {
        _showMaterialDropdown();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          color: context.theme.colorScheme.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? widget.hintText,
              style: TextStyle(
                color: selectedValue == null ? Colors.grey : Colors.black,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showMaterialDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: Get.height * 0.5,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "بحث...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _onSearchChanged(value);
                        });
                        Future.delayed(Duration(milliseconds: 1000), () {
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.onSearch == null
                              ? filteredItems.length
                              : widget.items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(widget.onSearch == null
                                  ? filteredItems[index]
                                  : widget.items[index]),
                              onTap: () {
                                setState(() {
                                  selectedValue = widget.onSearch == null
                                      ? filteredItems[index]
                                      : widget.items[index];
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(widget.onSearch == null
                                      ? filteredItems[index]
                                      : widget.items[index]);
                                }
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

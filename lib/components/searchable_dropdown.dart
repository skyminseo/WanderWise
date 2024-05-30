import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:wander_wise/resources/color.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final String labelText;
  final T selectedValue;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final Color boxColor;

  const SearchableDropdown({
    Key? key,
    required this.labelText,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.boxColor,
  }) : super(key: key);

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.boxColor, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.only(
              top: 4,
              bottom: 4,
            ),
            margin: EdgeInsets.only(
              bottom: 12,
              left: 4,
              right: 4,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                isExpanded: true,
                hint: Text(
                  'Select ${widget.labelText}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: widget.items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
                value: widget.selectedValue,
                onChanged: widget.onChanged,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 150,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());
                  },
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/fanzone/model/filter_enum.dart';
import 'package:my_taraji/views/fanzone/provider/fanzone_provider.dart';
import 'package:provider/provider.dart';

class FanzoneSearch extends StatelessWidget {
  const FanzoneSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: buildSearch(context),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildFilter(context),
                ...context.watch<FanzoneProvider>().filters.map(
                      (chip) => buildFilterButton(chip, context),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearch(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: MyColors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        // onChanged: (value) =>
        //     context.read<TransfertProvider>().searchContacts(value),
        decoration: InputDecoration(
          hintText: "Rechercher un contact",
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff9CA3AF),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: const Color(0xff9CA3AF).withOpacity(0.3),
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          prefixIcon: const Icon(
            TablerIcons.search,
            color: MyColors.yellow,
          ),
        ),
      ),
    );
  }

  Widget buildFilterChip(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          SvgPicture.asset(
            'images/icons/drag.svg',
            height: 5,
            width: 5,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Trier par',
            style: TextStyle(
              color: MyColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 20,
              children: FilterFanzone.values.map(
                (FilterFanzone chip) {
                  return FilterChip(
                    selectedColor: MyColors.yellow,
                    backgroundColor: MyColors.white,
                    side: const BorderSide(
                      color: MyColors.yellow,
                      width: 1,
                    ),
                    label: Text(
                      chip.name,
                      style: const TextStyle(
                        color: MyColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected:
                        context.watch<FanzoneProvider>().filters.contains(chip),
                    onSelected: (bool selected) {
                      context.read<FanzoneProvider>().toggleFilter(chip);
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilter(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          scrollControlDisabledMaxHeightRatio: 0.2,
          enableDrag: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return buildFilterChip(context);
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: 70,
        decoration: BoxDecoration(
          color: MyColors.yellow,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Icon(
            TablerIcons.adjustments_horizontal,
            color: MyColors.white,
          ),
          Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              context.watch<FanzoneProvider>().filters.length.toString(),
            ),
          )
        ]),
      ),
    );
  }

  Widget buildFilterButton(FilterFanzone chip, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.yellow.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chip.name,
            style: const TextStyle(
              color: MyColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              context.read<FanzoneProvider>().toggleFilter(chip);
            },
            child: const Icon(
              Icons.close,
              color: MyColors.red,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

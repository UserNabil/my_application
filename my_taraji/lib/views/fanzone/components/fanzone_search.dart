import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/theme/my_color.dart';

class FanzoneSearch extends StatelessWidget {
  const FanzoneSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearch(context),
        const SizedBox(height: 5),
        buildFilter(context),
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

  Widget buildFilter(BuildContext context) {
    // Wrap(
    //       spacing: 5.0,
    //       children: ExerciseFilter.values.map((ExerciseFilter exercise) {
    //         return FilterChip(
    //           label: Text(exercise.name),
    //           selected: filters.contains(exercise),
    //           onSelected: (bool selected) {
    //             setState(() {
    //               if (selected) {
    //                 filters.add(exercise);
    //               } else {
    //                 filters.remove(exercise);
    //               }
    //             });
    //           },
    //         );
    //       }).toList(),
    //     ),
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          enableDrag: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return const FilterChipExample();
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
            child: const Text("2"),
          )
        ]),
      ),
    );
  }
}

enum ExerciseFilter { walking, running, cycling, hiking }

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};

  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.centerLeft,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 0,
              children: ExerciseFilter.values.map(
                (ExerciseFilter exercise) {
                  return FilterChip(
                    backgroundColor: MyColors.yellow,
                    side: BorderSide.none,
                    label: Text(
                      exercise.name,
                      style: const TextStyle(
                        color: MyColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected: filters.contains(exercise),
                    onSelected: (bool selected) {
                      setState(
                        () {
                          if (selected) {
                            filters.add(exercise);
                          } else {
                            filters.remove(exercise);
                          }
                        },
                      );
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
}

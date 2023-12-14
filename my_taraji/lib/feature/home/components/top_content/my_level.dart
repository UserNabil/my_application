import 'package:flutter/material.dart';
import 'package:my_taraji/feature/home/components/my_progress.dart';
import '../../../../core/theme/my_color.dart';

class MyCardLevel extends StatelessWidget {
  const MyCardLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Top
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("MyTaraji",
                    style: TextStyle(fontSize: 11, color: MyColors.yellow))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Programme de fidélité",
                    style: TextStyle(
                        fontSize: 17,
                        color: MyColors.black,
                        fontWeight: FontWeight.w600))
              ],
            )
          ],
        ),
        // Middle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Niveau actuel",
                    style: TextStyle(fontSize: 11, color: MyColors.grey)),
                Text("SILVER",
                    style: TextStyle(
                        fontSize: 25,
                        color: MyColors.grey,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Points",
                                style: TextStyle(
                                    fontSize: 11, color: MyColors.red)),
                            Text("0",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: MyColors.red,
                                    fontWeight: FontWeight.w700)),
                          ]),
                      SizedBox(width: 10),
                      Image(image: AssetImage("images/taraji.png"), width: 50),
                    ]),
              ],
            )
          ],
        ),
        // Bottom
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Silver",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text("Gold",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [MyProgressBar(value: 75)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("XP:2840/5000",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text("74,3%",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black))
              ],
            )
          ],
        )
      ],
    );
  }
}

class MyLevel extends StatelessWidget {
  const MyLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.transparent,
      ),
      child: const MyCardLevel(),
    );
  }
}

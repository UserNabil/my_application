import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_taraji/views/selfcare/components/transations/transaction_lister.dart';
import '../../../core/theme/my_color.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({super.key});

  @override
  ListTransactionState createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          'images/icons/drag.svg',
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mes Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: MyColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const TransactionLister()
      ],
    );
  }
}

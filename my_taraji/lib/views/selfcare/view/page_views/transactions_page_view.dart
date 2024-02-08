import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/assets/images_svg.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/transaction_service.dart';
import 'package:my_taraji/views/selfcare/models/fakedata.dart';
import 'package:my_taraji/views/selfcare/view/widgets/card_transaction.dart';

class TransactionsPageView extends StatelessWidget {
  const TransactionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionService transactionService = TransactionService();
    var screenSize = MediaQuery.of(context).size;
    SelfcareFakeData fakeData = SelfcareFakeData();
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          dividerGreySVG,
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Mes Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: MyColors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder(
          future: transactionService.getTransactionHistories(
              order: "desc", page: 0, size: 10, sort: "createdAt"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: screenSize.height - 315,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: screenSize.height - 315,
                child: Center(
                  child: Text('Erreur: ${snapshot.error}'),
                ),
              );
            } else {
              return SizedBox(
                height: screenSize.height - 315,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CardTransaction(
                          imageName: fakeData.cardData[index]['imageName']!,
                          title: fakeData.cardData[index]['title']!,
                          description: fakeData.cardData[index]['description']!,
                          xpText: fakeData.cardData[index]['xpText']!,
                          coin: fakeData.cardData[index]['coin']!,
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

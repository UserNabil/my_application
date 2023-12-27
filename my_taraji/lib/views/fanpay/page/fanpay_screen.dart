import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/fanpay/fanpay_top.dart';

class MyFanPay extends StatelessWidget {
  const MyFanPay({super.key});
  static const routeName = '/fanpay';

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? 'Error';

    return {
      'name': name,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final userData = snapshot.data!;
        return buildPage(userData);
      },
    );
  }

  Widget buildPage(Map<String, String> userData) {
    List<Widget> widgetsToDisplay = [
      TopFanPay(userData: userData),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widgetsToDisplay.length,
                  itemBuilder: (context, index) {
                    return widgetsToDisplay[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

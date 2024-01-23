import 'package:flutter/material.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_in_izi.dart';

class FanPayIzi extends StatefulWidget {
  const FanPayIzi({super.key});

  @override
  FanPayIziState createState() => FanPayIziState();
}

class FanPayIziState extends State<FanPayIzi> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(120, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SingUpScreen(
                controller: controller,
              )
            ],
          ),
        ),
      ),
    );
  }
}

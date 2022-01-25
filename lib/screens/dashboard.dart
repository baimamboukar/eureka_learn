import 'package:eureka_learn/utils/palette.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Row(
                children: [
                  Card(
                    color: Palette.primary,
                    child: Container(
                      child: Stack(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

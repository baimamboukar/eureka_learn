import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 25.0,
          ),
          Text("Loading...Please wait", style: Styles.subtitle)
        ],
      ),
    );
  }
}

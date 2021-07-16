import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Text("Hello")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Text("Hello");
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Hello");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("Hello");
  }
}

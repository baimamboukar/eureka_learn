import 'package:eureka_learn/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsController extends StateNotifier<List<PostModel>> {
  // ignore: unused_field
  final Reader _read;
  PostsController(this._read, List<PostModel> posts) : super([]);
  List<PostModel> get feeds => state;

  set data(List<PostModel> feeds) => state = feeds;
} 

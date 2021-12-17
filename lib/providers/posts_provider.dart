import 'package:eureka_learn/controllers/controllers.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsControllerProvider =
    StateNotifierProvider.autoDispose<PostsController, List<PostModel>>(
        (ref) => PostsController(ref.read, []));

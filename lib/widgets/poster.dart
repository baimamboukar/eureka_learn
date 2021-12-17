import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/services/notifications.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final tagsProvider = StateProvider<List<String>>((ref) => []);
final fileProvider = StateProvider<File?>((ref) => null);
final photoProvider = StateProvider<String?>((ref) => null);
final displayTagsProvider = StateProvider<bool>((ref) => false);
final isBusyProvider = StateProvider<bool>((ref) => false);
final uploadTaskProvider = StateProvider<UploadTask?>((ref) => null);
final downloadedURLProvider = StateProvider<String?>((ref) => null);
final backgroundColorProvider =
    StateProvider<Color?>((ref) => Colors.green.shade200);
var x = "gs://eurekalearn-d63d4.appspot.com";

class Poster extends StatefulHookWidget {
  @override
  _PosterState createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(studentControllerProvider.notifier);
    final database = useProvider(databaseProvider);
    TextEditingController messageController = useTextEditingController();
    final tags = useProvider(tagsProvider);
    final file = useProvider(fileProvider);
    // ignore: unused_local_variable
    final photos = useProvider(photoProvider);
    final background = useProvider(backgroundColorProvider);
    final displayTags = useProvider(displayTagsProvider);
    final isBusy = useProvider(isBusyProvider);
    final uploadTask = useProvider(uploadTaskProvider);
    final downloadedURL = useProvider(downloadedURLProvider);
    final notifications = useProvider(notificationsProvider);
    void pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File _file = File(result.files.first.path ?? "");
        print(_file.path);
        file.state = _file;
      } else {
        // User canceled the picker
      }
    }

    uploadImageToFirebase(File file) async {
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('posts_images/${DateTime.now()}.png');

      if (kIsWeb) {
        uploadTask.state = ref.putData(await file.readAsBytes());
        ref
            .putData(await file.readAsBytes())
            .then((url) => url.ref.getDownloadURL().then((imageURL) {
                  downloadedURL.state = imageURL;
                }));
      } else {
        uploadTask.state = ref.putFile(File(file.path));
        ref.putFile(File(file.path)).then((url) {
          url.ref.getDownloadURL().then((imageURL) {
            downloadedURL.state = imageURL;
          });
        });
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(text: "Hi, ", children: [
                      TextSpan(
                          text: user.student.names,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ]))
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                    color: background.state,
                    border: Border.all(color: Palette.primary, width: 1),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: TextFormField(
                      controller: messageController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefix: Text("✍️"),
                          hintText: "What comes in your mind ? ",
                          hintStyle: Styles.designText(
                              bold: false, color: Palette.light, size: 18.0))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var colors = [
                        Colors.red,
                        Colors.black,
                        Colors.amber,
                        Colors.blue,
                        Colors.purple
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            background.state = colors[index];
                          },
                          child: Container(
                              height: 35.0, width: 40.0, color: colors[index]),
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 10.0),
            if (file.state != null)
              Container(
                height: 235.0,
                width: 200.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.primary, width: 2.0)),
                child: Column(
                  children: [
                    Image.memory(file.state!.readAsBytesSync(),
                        height: 175.0,
                        width: 196.0,
                        colorBlendMode: BlendMode.overlay, frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                      return Padding(
                        padding: EdgeInsets.all(1.0),
                        child: child,
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(LineIcons.trash, color: Palette.error),
                            onPressed: () {
                              file.state = null;
                            })
                      ],
                    )
                  ],
                ),
              ),
            if (displayTags.state && messageController.text.length > 4 ||
                file.state != null)
              FlipInX(
                duration: Duration(milliseconds: 1500),
                delay: Duration(milliseconds: 500),
                child: Wrap(
                    spacing: 3.50,
                    children: tagsCloud
                        .map((tag) => JelloIn(
                              child: ChoiceChip(
                                selected: tags.state.contains(tag),
                                onSelected: (selected) {
                                  selected
                                      ? tags.state.add(tag)
                                      : tags.state.remove(tag);
                                  setState(() {});
                                },
                                label: Text(tag),
                              ),
                            ))
                        .toList()),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (messageController.text.length > 4 ||
                          file.state != null)
                        displayTags.state = true;
                      else
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Palette.error,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24.0),
                                          topRight: Radius.circular(24.0))),
                                  child: Center(
                                      child: Text("Must have some message")));
                            });
                    },
                    child: ActionButton(
                        label: "add tags",
                        color: Palette.success,
                        icon: Icon(LineIcons.tags, size: 14.0),
                        callback: () => print("exporting...")),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      pickFile();
                    },
                    child: ActionButton(
                        label: "add photo",
                        color: Palette.secondary,
                        icon: Icon(LineIcons.photoVideo, size: 14.0),
                        callback: () => print("exporting...")),
                  ),
                  const SizedBox(width: 30.0),
                  if (messageController.value.text.length > 4 ||
                      file.state != null)
                    FlipInY(
                      child: GestureDetector(
                        onTap: () {
                          isBusy.state = true;
                          if (isBusy.state)
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24.0),
                                              topRight: Radius.circular(24.0))),
                                      child: Center(
                                          child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const CircularProgressIndicator
                                              .adaptive(),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text("Posting....",
                                              style: Styles.subtitle),
                                        ],
                                      )));
                                });

                          if (file.state != null)
                            uploadImageToFirebase(
                                file.state ?? File(file.state!.path));
                          PostModel model = PostModel(
                              inGroup: false,
                              tags: tags.state,
                              withPicture: file.state != null ? true : false,
                              photoURL: file.state != null
                                  ? downloadedURL.state
                                  : null,
                              likesCount: 0,
                              timeAgo: DateTime.now().toString(),
                              label: messageController.value.text,
                              ownerId: user.student.id ?? "",
                              ownerLevel: user.student.level,
                              ownerAvatar: user.student.avatar,
                              ownerName: user.student.names,
                              comments: []);
                          if (database.post(model)) {
                            notifications.send(
                                channel: 'basic_channel',
                                title: "Successful Post",
                                summary: "new post",
                                body: "View your new post in the timeline",
                                callback: '/home');
                            Future.delayed(Duration(seconds: 1), () {
                              Get.to(() => Home());
                            });
                          }
                        },
                        child: ActionButton(
                            label: "Publish",
                            color: Palette.primary,
                            icon: Icon(LineIcons.telegram, size: 14.0),
                            callback: () {}),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

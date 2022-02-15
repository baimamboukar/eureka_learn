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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';

final tagsProvider = StateProvider<List<String>>((ref) => []);
final fileProvider = StateProvider<File?>((ref) => null);
final photoProvider = StateProvider<String?>((ref) => null);
final displayTagsProvider = StateProvider<bool>((ref) => false);
final isBusyProvider = StateProvider<bool>((ref) => false);
final uploadTaskProvider = StateProvider<UploadTask?>((ref) => null);
final downloadedURLProvider = StateProvider<String?>((ref) => null);
final backgroundColorProvider = StateProvider<Color?>((ref) => Colors.white24);
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
    final displayTags = useProvider(displayTagsProvider);
    final isBusy = useProvider(isBusyProvider);
    final notifications = useProvider(notificationsProvider);
    void pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File _file = File(result.files.first.path ?? "");
        print(_file.path);
        file.state = _file;
      } else {
        Toast.toast(
            color: Palette.secondary,
            title: "Meida upload",
            message: "No file has been selected",
            icon: Iconsax.image);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
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
                child: Card(
                  color: Palette.primary,
                  child: Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.elliptical(
                                Screen.width(context) * 0.4, 100))),
                    child: Center(
                      child: TextFormField(
                          controller: messageController,
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "What comes in your mind ? ",
                              hintStyle: Styles.designText(
                                  bold: false,
                                  color: Palette.light,
                                  size: 18.0))),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Container(
              //       height: 50.0,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 5,
              //         itemBuilder: (context, index) {
              //           var colors = [
              //             Colors.red,
              //             Colors.black,
              //             Colors.amber,
              //             Colors.blue,
              //             Colors.purple,
              //             Colors.pink
              //           ];
              //           return Padding(
              //             padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              //             child: GestureDetector(
              //               onTap: () {
              //                 background.state = colors[index];
              //               },
              //               child: Container(
              //                   height: 35.0,
              //                   width: 40.0,
              //                   color: colors[index]),
              //             ),
              //           );
              //         },
              //       )),
              // ),
              const SizedBox(height: 10.0),
              if (file.state != null)
                GestureDetector(
                  onTap: () => showBottomSheet(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () {
                              file.state = null;
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 75.0,
                                decoration: BoxDecoration(
                                    color: Palette.primary,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0))),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Delete photo",
                                        style: Styles.designText(
                                            bold: true,
                                            size: 20.0,
                                            color: Palette.dark)),
                                    const SizedBox(width: 6.0),
                                    Icon(LineIcons.trash, size: 18.0)
                                  ],
                                ))),
                          )),
                  child: Container(
                    height: 235.0,
                    width: 200.0,
                    child: Column(
                      children: [
                        Image.memory(file.state!.readAsBytesSync(),
                            colorBlendMode: BlendMode.overlay, frameBuilder:
                                (context, child, frame,
                                    wasSynchronouslyLoaded) {
                          return Padding(
                            padding: EdgeInsets.all(1.0),
                            child: child,
                          );
                        }),
                      ],
                    ),
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
                padding: const EdgeInsets.only(left: 8.0, top: 0.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (messageController.text.length > 4 ||
                            file.state != null)
                          displayTags.state = true;
                        else
                          Toast.toast(
                              color: Palette.error,
                              title: "Adding tags",
                              message: "You must have some message or image",
                              icon: Iconsax.tag);
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
                          icon: Icon(Icons.add_photo_alternate, size: 14.0),
                          callback: () => print("exporting...")),
                    ),
                    const SizedBox(width: 30.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              if (messageController.value.text.length > 4 || file.state != null)
                FlipInY(
                  child: GestureDetector(
                    onTap: () async {
                      isBusy.state = true;
                      if (isBusy.state)
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Palette.primary,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0))),
                                child: Column(
                                  children: [
                                    Text(
                                      "Posting feed...",
                                      style: Styles.subtitle,
                                    ),
                                    const SizedBox(height: 15.0),
                                    LinearProgressIndicator(
                                      minHeight: 6.0,
                                    )
                                  ],
                                ),
                              );
                            });

                      if (file.state != null)
                        await database
                            .uploadImage(file.state ?? File("file"))
                            .then((url) async {
                          PostModel model = PostModel(
                              inGroup: false,
                              tags: tags.state,
                              withPicture: file.state != null ? true : false,
                              photoURL: url,
                              likesCount: 0,
                              timeAgo: DateTime.now().toLocal().toString(),
                              label: messageController.value.text,
                              ownerId: user.student.id ?? "",
                              ownerLevel: user.student.level,
                              ownerAvatar: user.student.avatar,
                              ownerName: user.student.names,
                              comments: []);
                          if (database.post(model)) {
                            notifications.send(
                                channel: 'basic_channel',
                                title: "New post from ${model.ownerName}...",
                                summary: model.label,
                                body: model.label,
                                callback: '/home');
                            Toast.toast(
                                color: Palette.success,
                                message: "Successful posted",
                                title: "Publishing",
                                icon: LineIcons.circleAlt);
                            Future.delayed(Duration(seconds: 1), () {
                              Get.to(() => Home());
                            });
                          }
                        });
                      else {
                        PostModel model = PostModel(
                            inGroup: false,
                            tags: tags.state,
                            withPicture: file.state != null ? true : false,
                            photoURL: null,
                            likesCount: 0,
                            timeAgo: DateTime.now().toLocal().toString(),
                            label: messageController.value.text,
                            ownerId: user.student.id ?? "",
                            ownerLevel: user.student.level,
                            ownerAvatar: user.student.avatar,
                            ownerName: user.student.names,
                            comments: []);
                        if (database.post(model)) {
                          notifications.send(
                              channel: 'posts',
                              title: "New post from ${model.ownerName}...",
                              summary: model.label,
                              body: model.label,
                              callback: '/home');
                          Toast.toast(
                              color: Palette.success,
                              message: "Successful posted",
                              title: "Publishing",
                              icon: LineIcons.circleAlt);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          tags.state = [];
                          file.state = null;
                          messageController.clear();
                        }
                      }
                    },
                    child: Button(
                        label: "Publish",
                        color: Palette.primary,
                        icon: FontAwesomeIcons.telegramPlane),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

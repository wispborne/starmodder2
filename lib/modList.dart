import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:starmodder2/search.dart';
import 'package:starmodder2/state.dart' as state;
import 'package:text_search/text_search.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ModList extends ConsumerStatefulWidget {
  const ModList({super.key, this.query});

  final String? query;

  @override
  ConsumerState<ModList> createState() => _ModListState();
}

class _ModListState extends ConsumerState<ModList> {
  _ModListState();

  @override
  Widget build(BuildContext context) {
    final modRepo = ref.watch(state.allMods);
    final query = ref.watch(state.search);
    final mods = (query == null || modRepo == null)
        ? modRepo?.items
        : TextSearch(modRepo.items.map((element) => TextSearchItem(element, createSearchTags(element))).toList())
            .search(query)
            .map((e) => e.object)
            .toList();
    final locale = ref.watch(state.locale);

    final theme = Theme.of(context);
    final subtextColor = theme.textTheme.labelLarge?.color?.withAlpha(170);
    final subTextStyle = theme.textTheme.labelLarge?.copyWith(color: subtextColor);
    var titleStyle = theme.textTheme.headlineSmall;
    const buttonStyle = ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 13)),
        backgroundColor: MaterialStatePropertyAll(Colors.black26));
    const imageWidth = 380.0;
    const imageHeight = 100.0;
    const cellWidth = 500.0;
    const cellHeight = 450.0;

    return Container(
      child: mods == null
          ? const Text("Fetching...")
          : GridView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: cellWidth, mainAxisExtent: cellHeight, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: mods.length,
              itemBuilder: (context, indexOfMod) {
                final mod = mods[indexOfMod];
                final infoWidgets = [
                  if (mod.authorsList.isNotNullOrEmpty())
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, color: subtextColor),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Tooltip(
                                    message: mod.authorsList?.join(", "),
                                    child: Text(
                                      mod.authorsList?.join(", ") ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: subTextStyle,
                                    ))))
                      ],
                    ),
                  if (mod.gameVersionReq.isNotNullOrEmpty())
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.videogame_asset, color: subtextColor),
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(mod.gameVersionReq ?? "", style: subTextStyle))
                      ],
                    ),
                  if (mod.dateTimeCreated.isNotNullOrEmpty())
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.date_range,
                          color: subtextColor,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(DateFormat.yMd(locale).format(DateTime.parse(mod.dateTimeCreated ?? "")),
                                style: subTextStyle))
                      ],
                    ),
                  if (mod.categories.isNotNullOrEmpty())
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tag,
                          color: subtextColor,
                        ),
                        Expanded(
                            child: Tooltip(
                                message: mod.categories!.join(", "),
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(mod.categories!.join(", "),
                                        overflow: TextOverflow.ellipsis, style: subTextStyle))))
                      ],
                    )
                ];
                var images = mod.images?.values.toList(growable: false) ?? [];

                return Card(
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (mod.images?.values.isNotEmpty == true)
                              GestureDetector(
                                  onTap: () {
                                    final size = MediaQuery.of(context).size;
                                    _showMyDialog(context, maxWidth: size.width, body: [
                                      SizedBox(
                                          width: size.width,
                                          height: size.height - 100,
                                          child: DefaultTabController(
                                              length: images.length,
                                              child: Builder(builder: (BuildContext context) {
                                                final tabber = DefaultTabController.of(context)!;
                                                return Scaffold(
                                                  appBar: AppBar(
                                                      bottom: TabBar(
                                                    tabs: [
                                                      ...images
                                                          .map((img) => Tab(text: img.filename))
                                                          .toList(growable: false)
                                                    ],
                                                  )),
                                                  body: TabBarView(physics: PageScrollPhysics(), children: [
                                                    ...images.map((img) {
                                                      return Stack(alignment: Alignment.center, children: [
                                                        Image.network(img.url ?? ""),
                                                        Row(
                                                          children: [
                                                            ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(minWidth: 10, maxWidth: 120),
                                                                child: Expanded(
                                                                    child: InkWell(
                                                                  overlayColor: MaterialStatePropertyAll(
                                                                      Colors.black54.withOpacity(0.3)),
                                                                  child: Container(),
                                                                ))),
                                                            Spacer(),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  tabber.animateTo(tabber.index + 1);
                                                                },
                                                                child: ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(minWidth: 10, maxWidth: 120),
                                                                    child: Expanded(
                                                                        child: Container(
                                                                      color: Colors.black54.withOpacity(0.3),
                                                                    )))),
                                                          ],
                                                        )
                                                      ]);
                                                    }).toList(growable: false)
                                                  ]),
                                                );
                                              }))
                                          // ZoomablePhotoGallery(
                                          //     imageList: List.generate(
                                          //   images.length,
                                          //   (index) => Image.network(
                                          //       images[index].url ?? ""),
                                          // ),
                                          //   height: size.height - 150,
                                          // )
                                          )
                                      // SizedBox(
                                      //     width: size.width,
                                      //     height: size.height,
                                      //     child: PhotoViewGallery.builder(
                                      //       itemCount: images.length,
                                      //       builder: (BuildContext context,
                                      //               int index) =>
                                      //           PhotoViewGalleryPageOptions(
                                      //         imageProvider: NetworkImage(
                                      //             images[index].url ?? ""),
                                      //       ),
                                      //       loadingBuilder:
                                      //           (context, event) => Center(
                                      //         child: Container(
                                      //           width: 20.0,
                                      //           height: 20.0,
                                      //           child:
                                      //               CircularProgressIndicator(),
                                      //         ),
                                      //       ),
                                      //     ))
                                    ]);
                                  },
                                  child: Stack(children: [
                                    Center(
                                        child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: mod.images?.values.first.url ?? "",
                                      width: imageWidth,
                                      height: imageHeight,
                                      fit: BoxFit.fitWidth,
                                      fadeInDuration: const Duration(milliseconds: 100),
                                    )),
                                    HoverAnimatedContainer(
                                      color: Colors.black26.withAlpha(30),
                                      cursor: SystemMouseCursors.click,
                                      hoverColor: Colors.black26.withAlpha(00),
                                      height: imageHeight,
                                    )
                                  ]))
                            else
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black26.withAlpha(30),
                                    borderRadius: const BorderRadius.all(Radius.circular(3))),
                                height: imageHeight,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                  Opacity(
                                    opacity: 0.3,
                                    child: Icon(Icons.no_photography),
                                  )
                                ]),
                              ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Expanded(
                                      child: Text(
                                    mod.name ?? "",
                                    style: titleStyle,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: IconButton(
                                          onPressed: () {
                                            // TODO
                                            Clipboard.setData(ClipboardData());
                                          },
                                          icon: Icon(
                                            Icons.link,
                                            color: subtextColor,
                                          )))
                                ])),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              if (infoWidgets.isNotEmpty)
                                SizedBox(
                                    width: cellWidth / 3,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [...infoWidgets.filter((i) => infoWidgets.indexOf(i).isEven)])),
                              if (infoWidgets.isNotEmpty)
                                SizedBox(
                                    width: cellWidth / 3,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [...infoWidgets.filter((i) => infoWidgets.indexOf(i).isOdd)]))
                            ]),
                            const Divider(),
                            if (mod.summary != null)
                              Text(
                                mod.summary!,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            if (mod.summary != null)
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                      child: OutlinedButton(
                                          style:
                                              const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(18))),
                                          onPressed: () {
                                            _showMyDialog(context,
                                                title: mod.name,
                                                body: [MarkdownBody(data: mod.description ?? mod.summary!)]);
                                          },
                                          child: const Text("Read More")))),
                            const Spacer(),
                            const Divider(),
                            Row(
                              children: [
                                if (mod.urls?.containsKey("DirectDownload") == true)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black54,
                                          child: IconButton(
                                              onPressed: () {
                                                launchUrl(Uri.parse(mod.urls?["DirectDownload"] ?? ""),
                                                    webOnlyWindowName: "_blank");
                                              },
                                              icon: const Icon(Icons.file_download)))),
                                if (mod.urls?.containsKey("Discord") == true)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(mod.urls?["Discord"] ?? ""),
                                                webOnlyWindowName: "_blank");
                                          },
                                          style: buttonStyle,
                                          child: const Icon(Icons.discord))),
                                if (mod.urls?.containsKey("DownloadPage") == true)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(mod.urls?["DownloadPage"] ?? ""),
                                                webOnlyWindowName: "_blank");
                                          },
                                          style: buttonStyle,
                                          child: const Text("WEBSITE"))),
                                if (mod.urls?.containsKey("Forum") == true)
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            launchUrl(Uri.parse(mod.urls?["Forum"] ?? ""), webOnlyWindowName: "_blank");
                                          },
                                          style: buttonStyle,
                                          child: const Text("FORUM"))),
                              ],
                            )
                          ],
                        )));
              }),
    );
  }
}

Future<void> _showMyDialog(BuildContext context,
    {String? title, List<Widget>? body, double maxWidth = 900, double maxHeight = double.infinity}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title == null ? null : Text(title),
        content: SingleChildScrollView(
          child: SelectionArea(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: ListBody(
                    children: body ?? [],
                  ))),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

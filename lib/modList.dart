import 'package:collection/collection.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:starmodder2/models/modInfo.dart';
import 'package:starmodder2/photoViewer.dart';
import 'package:starmodder2/state.dart' as state;
import 'package:starmodder2/utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/link.dart';
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
    final mods = ref.watch(state.searchResultsProvider);
    final locale = ref.watch(state.locale);

    final theme = Theme.of(context);
    final subtextColor = theme.textTheme.labelLarge?.color?.withAlpha(170);
    final subTextStyle = theme.textTheme.labelLarge?.copyWith(color: subtextColor);
    var titleStyle = theme.textTheme.headlineSmall;
    const buttonStyle = ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 13)),
        backgroundColor: MaterialStatePropertyAll(Colors.black26));
    const cellWidth = 500.0;
    const cellHeight = 450.0;

    return Container(
      child: mods == null
          ? const Text("Fetching...")
          : GridView.builder(
              padding: const EdgeInsets.only(top: 20),
              clipBehavior: Clip.none,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: cellWidth, mainAxisExtent: cellHeight, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: mods.length,
              itemBuilder: (context, indexOfMod) {
                final mod = mods[indexOfMod];
                final images = mod.images?.values.toList(growable: false) ?? [];
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
                var discordUri = mod.urls?[ModUrlType.Discord.name];
                var downloadUri = mod.urls?[ModUrlType.DownloadPage.name];
                var directDownloadUri = mod.urls?[ModUrlType.DirectDownload.name];
                var forumUri = mod.urls?[ModUrlType.Forum.name];

                return SelectionArea(
                    child: Card(
                        elevation: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  ModImage(mod, images),
                                  // Anchor link button
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Tooltip(
                                            message: "Click to copy link",
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Opacity(
                                                  opacity: 0.4,
                                                  child: IconButton(
                                                    icon: const Icon(Icons.link),
                                                    onPressed: () => {
                                                      Clipboard.setData(ClipboardData(
                                                          text: Uri.base
                                                              .replace(query: "q=\"${mod.searchTags[1]}\"")
                                                              .toString()))
                                                    },
                                                  )),
                                            ),
                                          ),
                                        ),
                                        if (images.length > 1)
                                          const Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                                padding: EdgeInsets.only(right: 12.0),
                                                child: Opacity(
                                                    opacity: 0.2,
                                                    child: Icon(
                                                      Icons.photo_library,
                                                    ))),
                                          )
                                      ],
                                    ),
                                  ),
                                ]),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Expanded(
                                          child: Text(
                                        mod.name ?? "",
                                        style: titleStyle,
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      // Padding(
                                      //     padding: const EdgeInsets.only(left: 30),
                                      //     child: IconButton(
                                      //         onPressed: () {
                                      //           // TODO
                                      //           Clipboard.setData(const ClipboardData());
                                      //         },
                                      //         icon: Icon(
                                      //           Icons.link,
                                      //           color: subtextColor,
                                      //         )))
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
                                              style: const ButtonStyle(
                                                  padding: MaterialStatePropertyAll(EdgeInsets.all(18))),
                                              onPressed: () {
                                                showMyDialog(context,
                                                    title: Text(mod.name ?? ""),
                                                    body: [MarkdownBody(data: mod.description ?? mod.summary!)]);
                                              },
                                              child: const Text("Read More")))),
                                const Spacer(),
                                const Divider(),
                                Row(
                                  children: [
                                    // Direct download button
                                    if (directDownloadUri != null)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: directDownloadUri,
                                              child: Link(
                                                  uri: Uri.tryParse(directDownloadUri),
                                                  builder: (context, followLink) => CircleAvatar(
                                                      foregroundColor: Colors.white,
                                                      backgroundColor: Colors.black54,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            launchUrl(Uri.parse(directDownloadUri ?? ""),
                                                                webOnlyWindowName: "_blank");
                                                          },
                                                          icon: const Icon(Icons.file_download)))))),
                                    // Discord button
                                    if (discordUri != null)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: discordUri,
                                              child: Link(
                                                uri: Uri.tryParse(discordUri),
                                                builder: (context, followLink) => ElevatedButton(
                                                    onPressed: () {
                                                      launchUrl(Uri.parse(discordUri ?? ""),
                                                          webOnlyWindowName: "_blank");
                                                    },
                                                    style: buttonStyle,
                                                    child: const Icon(Icons.discord)),
                                              ))),
                                    // If the download page is different from the forum page, show a button for the download page
                                    if (mod.urls?.containsKey(ModUrlType.DownloadPage.name) == true &&
                                        forumUri != mod.urls?[ModUrlType.DownloadPage.name])
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: discordUri,
                                              child: Link(
                                                  uri: Uri.tryParse(downloadUri!),
                                                  builder: (context, followLink) => ElevatedButton(
                                                      onPressed: () {
                                                        launchUrl(Uri.parse(downloadUri ?? ""),
                                                            webOnlyWindowName: "_blank");
                                                      },
                                                      style: buttonStyle,
                                                      child: const Text("WEBSITE"))))),
                                    // Forum button
                                    if (forumUri != null)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: forumUri,
                                              child: Link(
                                                  uri: Uri.tryParse(forumUri),
                                                  builder: (context, followLink) => ElevatedButton(
                                                      onPressed: () {
                                                        launchUrl(Uri.parse(forumUri ?? ""),
                                                            webOnlyWindowName: "_blank");
                                                      },
                                                      style: buttonStyle,
                                                      child: const Text("FORUM"))))),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Tooltip(
                                          message:
                                              "*Search tags & score penalty*\n${mod.searchTags.sortedBy<num>((e) => e.scorePenalty).map((e) => "${e.term} (-${e.scorePenalty})").join("\n")}",
                                          child: const Opacity(opacity: 0.1, child: Icon(Icons.bug_report))),
                                    )
                                  ],
                                )
                              ],
                            ))));
              }),
    );
  }
}

class ModImage extends StatelessWidget {
  const ModImage(
    this.mod,
    this.images, {
    super.key,
  });

  final ModInfo mod;
  final images;

  @override
  Widget build(BuildContext context) {
    const imageWidth = 380.0;
    const imageHeight = 100.0;
    final theme = Theme.of(context);

    var noImageWidget = Container(
      decoration: BoxDecoration(
          color: Colors.black26.withAlpha(30), borderRadius: const BorderRadius.all(Radius.circular(3))),
      height: imageHeight,
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Opacity(
          opacity: 0.3,
          child: Icon(Icons.no_photography),
        )
      ]),
    );

    if (mod.images?.values.isNotEmpty == true) {
      return GestureDetector(
          onTap: () {
            final windowSize = MediaQuery.of(context).size;
            showMyDialog(context, maxWidth: windowSize.width, body: [PhotoViewer(images)]);
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
                    imageErrorBuilder: (context, error, stackTrace) {
                      return noImageWidget;
                    })),
            HoverAnimatedContainer(
              color: Colors.black26.withAlpha(30),
              cursor: SystemMouseCursors.click,
              hoverColor: Colors.black26.withAlpha(00),
              height: imageHeight,
            )
          ]));
    } else {
      return noImageWidget;
    }
  }
}

enum ModUrlType {
  DirectDownload,
  Discord,
  Forum,
  DownloadPage,
}

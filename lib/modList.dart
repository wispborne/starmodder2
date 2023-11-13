import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hovering/hovering.dart';
import 'package:intl/intl.dart';
import 'package:starmodder2/photoViewer.dart';
import 'package:starmodder2/state.dart' as state;
import 'package:starmodder2/utils.dart';
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
    const imageWidth = 380.0;
    const imageHeight = 100.0;
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

                return SelectionArea(
                    child: Card(
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
                                        )),
                                        HoverAnimatedContainer(
                                          color: Colors.black26.withAlpha(30),
                                          cursor: SystemMouseCursors.click,
                                          hoverColor: Colors.black26.withAlpha(00),
                                          height: imageHeight,
                                        ),
                                        if (images.length > 1)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                  child: Icon(
                                                    Icons.photo_library,
                                                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                                                    shadows: const [Shadow(blurRadius: 2)],
                                                  ))
                                            ],
                                          )
                                      ]))
                                else
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black26.withAlpha(30),
                                        borderRadius: const BorderRadius.all(Radius.circular(3))),
                                    height: imageHeight,
                                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Opacity(
                                        opacity: 0.3,
                                        child: Icon(Icons.no_photography),
                                      )
                                    ]),
                                  ),
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
                                    if (mod.urls?.containsKey(ModUrlType.DirectDownload.name) == true)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: mod.urls?[ModUrlType.DirectDownload.name],
                                              child: CircleAvatar(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.black54,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        launchUrl(
                                                            Uri.parse(mod.urls?[ModUrlType.DirectDownload.name] ?? ""),
                                                            webOnlyWindowName: "_blank");
                                                      },
                                                      icon: const Icon(Icons.file_download))))),
                                    if (mod.urls?.containsKey(ModUrlType.Discord.name) == true)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: mod.urls?[ModUrlType.Discord.name],
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(mod.urls?[ModUrlType.Discord.name] ?? ""),
                                                        webOnlyWindowName: "_blank");
                                                  },
                                                  style: buttonStyle,
                                                  child: const Icon(Icons.discord)))),
                                    if (mod.urls?.containsKey(ModUrlType.DownloadPage.name) == true &&
                                        mod.urls?[ModUrlType.Forum.name] != mod.urls?[ModUrlType.DownloadPage.name])
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: mod.urls?[ModUrlType.DownloadPage.name],
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(mod.urls?[ModUrlType.DownloadPage.name] ?? ""),
                                                        webOnlyWindowName: "_blank");
                                                  },
                                                  style: buttonStyle,
                                                  child: const Text("WEBSITE")))),
                                    if (mod.urls?.containsKey(ModUrlType.Forum.name) == true)
                                      Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Tooltip(
                                              message: mod.urls?[ModUrlType.Forum.name],
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    launchUrl(Uri.parse(mod.urls?[ModUrlType.Forum.name] ?? ""),
                                                        webOnlyWindowName: "_blank");
                                                  },
                                                  style: buttonStyle,
                                                  child: const Text("FORUM")))),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Tooltip(
                                          message: "*Search tags*\n${mod.searchTags.join("\n")}",
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

enum ModUrlType {
  DirectDownload,
  Discord,
  Forum,
  DownloadPage,
}

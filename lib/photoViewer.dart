import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starmodder2/models/modImage.dart';
import 'package:stringr/stringr.dart';

class PhotoViewer extends StatefulWidget {
  PhotoViewer(this.images, {super.key});

  List<ModImage> images;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    final images = widget.images;

    return SizedBox(
        width: windowSize.width,
        height: windowSize.height - 200,
        child: DefaultTabController(
            length: images.length,
            child: Builder(builder: (BuildContext context) {
              final tabber = DefaultTabController.of(context)!;

              return CallbackShortcuts(
                  bindings: {
                    const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
                      if (tabber.index > 0) tabber.animateTo(tabber.index - 1);
                    },
                    const SingleActivator(LogicalKeyboardKey.arrowRight): () {
                      if (tabber.index < images.length - 1) tabber.animateTo(tabber.index + 1);
                    }
                  },
                  child: Focus(
                      autofocus: true,
                      child: Scaffold(
                        appBar: AppBar(
                            bottom: TabBar(
                          tabs: [...images.map((img) => Tab(text: img.filename)).toList(growable: false)],
                        )),
                        body: TabBarView(children: [
                          ...images.mapIndex((img, index) {
                            return Stack(alignment: Alignment.center, children: [
                              InteractiveViewer(
                                  minScale: 1.0,
                                  clipBehavior: Clip.none,
                                  maxScale: 3.0,
                                  child: Image.network(img.url ?? "")),
                              Row(
                                children: [
                                  if (index > 0)
                                    SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          hoverColor: Colors.black54.withOpacity(0.6),
                                          onTap: () {
                                            tabber.animateTo(tabber.index - 1);
                                          },
                                          child: Container(
                                            color: Colors.black54.withOpacity(0.2),
                                            constraints: const BoxConstraints.expand(),
                                            child: const Icon(Icons.arrow_left),
                                          ),
                                        )),
                                  const Spacer(),
                                  if (images.length > 1 && index < images.length - 1)
                                    SizedBox(
                                      width: 150,
                                      child: InkWell(
                                          hoverColor: Colors.black54.withOpacity(0.6),
                                          onTap: () {
                                            tabber.animateTo(tabber.index + 1);
                                          },
                                          child: Container(
                                            color: Colors.black54.withOpacity(0.2),
                                            constraints: const BoxConstraints.expand(),
                                            child: const Icon(Icons.arrow_right),
                                          )),
                                    ),
                                ],
                              )
                            ]);
                          }).toList(growable: false)
                        ]),
                      )));
            })));
  }
}

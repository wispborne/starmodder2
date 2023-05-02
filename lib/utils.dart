import 'dart:math';

import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:stringr/stringr.dart';

final _upperReg = RegExp(r'[A-Z]');
extension Append on String {
  String prepend(String text) => text + this;

  String append(String text) => this + text;

  String acronym() => split(" ").map((e) => e.first(1).upperCase() + e.chars().skip(1).filter((element) => element?.contains(_upperReg) ?? false).join()).join();
}

extension ListExt<T> on List<T> {
  T random() {
    return this[Random().nextInt(length - 1)];
  }
}

extension ItrItrExt<T> on Iterable<Iterable<T>> {
  Iterable<T> intersect() {
    return fold<Set<T>>(first.toSet(), (a, b) => a.intersection(b.toSet()));
  }
}

Future<void> showMyDialog(BuildContext context,
    {Widget? title, List<Widget>? body, double maxWidth = 900, double maxHeight = double.infinity}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
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

final modSourcesByJsonKey = {
  ModSourceEnum.Index.name: ModSource(ModSourceEnum.Index, "Forum"),
  ModSourceEnum.Discord.name: ModSource(ModSourceEnum.Discord, "Discord"),
  ModSourceEnum.NexusMods.name: ModSource(ModSourceEnum.NexusMods, "Nexus"),
  ModSourceEnum.ModdingSubforum.name: ModSource(ModSourceEnum.ModdingSubforum, "Forum"),
};

enum ModSourceEnum {
  Index,
  ModdingSubforum,
  Discord,
  NexusMods,
}

class ModSource {
  ModSource(this.modEnum, this.displayName);

  final ModSourceEnum modEnum;
  final String displayName;
}

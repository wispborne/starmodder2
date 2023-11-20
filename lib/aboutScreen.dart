import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

showAboutScreenDialog(BuildContext context) {
  final theme = Theme.of(context);

  showAboutDialog(context: context, applicationName: appTitle.replaceAll("2", version), applicationVersion: "$subtitle by Wisp", children: [
    ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            const Divider(),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Created using Flutter, by Google "),
              TextSpan(text: "so it'll probably get discontinued next year.", style: theme.textTheme.bodySmall)
            ])),
            Linkify(
              text: "Source Code: https://github.com/wispborne/starmodder2",
              linkifiers: const [UrlLinkifier()],
              onOpen: (link) => launchUrl(Uri.parse(link.url)),
            ),
            Linkify(
              text: "Raw data: https://github.com/wispborne/StarsectorModRepo",
              linkifiers: const [UrlLinkifier()],
              onOpen: (link) => launchUrl(Uri.parse(link.url)),
            ),
          ],
        ))
  ]);
}

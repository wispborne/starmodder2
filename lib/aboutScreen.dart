import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:starmodder2/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

showAboutScreenDialog(BuildContext context) {
  final theme = Theme.of(context);

  showMyDialog(context,
      title: Center(
          child: Column(children: [
        Text(
          appTitle,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
        Text(subtitle, style: theme.textTheme.labelLarge),
        Text("by Wisp", style: theme.textTheme.labelLarge),
        const Divider(),
      ])),
      body: [
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Text(
                //   "What's it do?",
                //   style: theme.textTheme.titleLarge,
                // ),
                // SizedBox.fromSize(
                //   size: const Size.fromHeight(5),
                // ),
                // const Text(
                //     "The first part of troubleshooting Starsector issues is looking through a log file for errors, and often checking for outdated mods.\nChipper pulls useful information out of the log for easier viewing."),
                // SizedBox.fromSize(
                //   size: const Size.fromHeight(20),
                // ),
                // Text(
                //   "What do you do with my logs?",
                //   style: theme.textTheme.titleLarge,
                // ),
                // SizedBox.fromSize(
                //   size: const Size.fromHeight(5),
                // ),
                // const Text(
                //     "Everything is done on your browser. Neither the file nor any part of it are ever sent over the Internet.\nI do not collect any analytics except for what Cloudflare, the hosting provider, collects by default, which is all anonymous."),
                // SizedBox.fromSize(
                //   size: const Size.fromHeight(30),
                // ),
                Text.rich(TextSpan(children: [
                  const TextSpan(text: "Created using Flutter, by Google "),
                  TextSpan(text: "so it'll probably get discontinued next year.", style: theme.textTheme.bodySmall)
                ])),
                Linkify(
                  text: "Source Code: https://github.com/wispborne/starmodder2",
                  linkifiers: const [UrlLinkifier()],
                  onOpen: (link) => launchUrl(Uri.parse(link.url)),
                ),
              ],
            ))
      ]);
}

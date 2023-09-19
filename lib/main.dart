import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:platform_info/platform_info.dart';
import 'package:starmodder2/logging.dart';
import 'package:starmodder2/modList.dart';
import 'package:starmodder2/state.dart' as appState;
import 'package:starmodder2/themes.dart';
import 'package:starmodder2/utils.dart';
import 'package:window_size/window_size.dart';

import 'aboutScreen.dart';
import 'business.dart';
import 'models/modRepo.dart';

const appTitle = "Starmodder 2";
const version = "2.2";
const subtitle = "An unofficial Starsector mod database";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLogging(printPlatformInfo: true);
  setWindowTitle(appTitle);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(brightness: Brightness.light, primarySwatch: Colors.cyan, hintColor: Colors.cyanAccent),
        dark: Themes.starsectorLauncher,
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) => MaterialApp.router(
              title: appTitle,
              theme: theme,
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme,
              routerConfig: _router,
            ));
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage(title: appTitle, query: state.pathParameters["q"]);
        },
      )
    ],
  );

  @override
  void initState() {
    super.initState();
    if (Platform.I.isWeb) {
      // findSystemLocale().then(
      //     (value) => ref.read(state.locale.notifier).update((state) => value));
    }
    refresh(ref);
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title, this.query});

  final String title;
  final String? query;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.black,
          title: Row(
            children: [
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.title),
                Text(
                  subtitle,
                  style: theme.textTheme.labelLarge,
                )
              ])),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: 500,
                    height: 35,
                    child:
                        // SearchAnchor(
                        // builder: (context, controller) => SearchBar(
                        //       controller: controller,
                        //       leading: const Icon(Icons.search),
                        //       onChanged: (text) {
                        //         controller.text = text;
                        //       },
                        //     ),
                        // suggestionsBuilder: (context, controller)  => []),
                        TextField(
                            autofocus: true,
                            controller: controller,
                            onChanged: (text) => ref.read(appState.search.notifier).update((state) => text),
                            decoration: InputDecoration(
                                hintText: "Search",
                                // icon: const Icon(Icons.search),
                                prefixIcon: const Icon(Icons.search),
                                suffix: InkWell(
                                    onTap: () {
                                      controller.clear();
                                      ref.read(appState.search.notifier).update((state) => null);
                                    },
                                    child: const SizedBox(
                                        height: 16,
                                        child: Icon(
                                          Icons.clear,
                                          size: 16.0,
                                        ))),
                                isDense: true))),
                Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      "Search using name, author, game version, category, or source (eg Discord)",
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: theme.textTheme.labelMedium?.color?.withOpacity(0.7)),
                    ))
              ]),
              const Spacer(),
              IconButton(
                  tooltip: "About Starmodder",
                  onPressed: () => showAboutScreenDialog(context),
                  icon: const Icon(Icons.info))
            ],
          )),
      body: Stack(children: [
        Padding(padding: const EdgeInsets.only(left: 15, top: 10), child: GeneratedTimeText()),
        Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(width: 1300.0), child: ModList(query: widget.query))),
        ),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     refresh(ref);
      //   },
      //   tooltip: 'Refresh',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();

    ref.read(appState.search.notifier).update((s) => widget.query);
  }
}

void refresh(WidgetRef ref) {
  compute<List<String>, ModRepo?>(fetchAndParseModInfo, []).then((value) {
    Fimber.i("Updating state with ${value?.totalCount} new mods.");
    return ref.read(appState.allMods.notifier).update((state) => value);
  });
}

class GeneratedTimeText extends ConsumerWidget {
  const GeneratedTimeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lastUpdatedDate = DateTime.parse(ref.watch(appState.allMods)?.lastUpdated ?? "1984-06-08T00:00:00Z");
    final theme = Theme.of(context);
    return Text(
      // DateTime.parse(ref.read(appState.allMods)?.lastUpdated ?? "0").isUtc.toString(),
      "generated ${DateFormat.MMMd().add_jm().format(lastUpdatedDate)} ${lastUpdatedDate.timeZoneName.acronym()}",
      style: theme.textTheme.labelMedium?.copyWith(color: theme.textTheme.labelMedium?.color?.withOpacity(0.7)),
    );
  }
}

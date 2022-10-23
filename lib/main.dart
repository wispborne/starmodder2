import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_info/platform_info.dart';
import 'package:starmodder2/logging.dart';
import 'package:starmodder2/modList.dart';
import 'package:starmodder2/state.dart' as appState;

import 'business.dart';
import 'models/modRepo.dart';

void main() {
  initLogging(printPlatformInfo: true);
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
    return MaterialApp.router(
      title: 'Starmodder',
      theme: ThemeData.dark(useMaterial3: false).copyWith(primaryColor: Colors.cyan),
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage(
              title: 'Starmodder 2', query: state.queryParams["q"]);
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            decoration: InputDecoration(
                hintText: widget.title)),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 1300.0),
                child: ModList(query: widget.query))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refresh(ref);
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
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

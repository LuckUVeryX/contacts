import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'core/data/datasources/contacts_local_datasource.dart';
import 'core/data/repositories/contacts_repostory_impl.dart';
import 'core/observers/observers.dart';
import 'core/router/router.gr.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  // Sets the logging level.
  Logger.level = Level.info;

  WidgetsFlutterBinding.ensureInitialized();
  final repository = ContactsRepository(ContactsLocalDataSource());
  await repository.init();

  BlocOverrides.runZoned(
    () => runApp(
      RepositoryProvider(create: (_) => repository, child: MyApp()),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Contacts',
      theme: AppTheme.lightTheme,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [RouterLoggingObserver()],
      ),
    );
  }
}

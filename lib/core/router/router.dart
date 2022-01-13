import 'package:auto_route/auto_route.dart';

import '../../features/contacts_list/presentation/pages/contacts_list_page.dart';
import '../../features/edit_contact/presentation/pages/edit_contact_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // Add routes here
    AutoRoute(page: ContactsListPage, initial: true, path: Routes.initial),
    AutoRoute(page: EditContactsPage, path: Routes.editContacts),
  ],
)

/// [AppRouter] to handle navigation in DemoApp
///
/// Use `flutter packages pub run build_runner build` to generate routes
///
/// To give a page a path, just set it's path field like so:
/// `AutoRoute(path: "/books", page: BooksPage)`
///
/// Now, we can easily navigate to this page via deep link, or with the pushPath function:
/// `AutoRouter.of(context).pushNamed(Routes.home)`
///
/// https://autoroute.vercel.app/
class $AppRouter {}

class Routes {
  static const initial = '/contacts';
  static const editContacts = '/edit';
}

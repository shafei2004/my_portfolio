import 'package:go_router/go_router.dart';
import 'package:my_portfolio/features/about/pages/about_page.dart';
import 'package:my_portfolio/features/contacts/pages/contact_page.dart';
import 'package:my_portfolio/features/home/pages/home_page.dart';
import 'package:my_portfolio/features/projects/pages/projects_details_page.dart';
import 'package:my_portfolio/features/projects/pages/projects_page.dart';
import 'package:my_portfolio/topbar.dart';

abstract class AppRouter {
  static const kInitialRoute = '/';
  static const kHomePage = '/home_page';
  static const kAboutPage = '/about_page';
  static const kProjectsPage = '/projects_page';
  static const kProjectsDetailsPage = '/projects_details_page';
  static const kContactsPage = '/contactes_page';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kInitialRoute, builder: (context, state) => const TopBar()),
      GoRoute(
        path: kProjectsDetailsPage,
        builder: (context, state) => ProjectDetailPage(
          projectId: state.uri.queryParameters['slug'] ?? '',
        ),
      ),
    ],
  );
}

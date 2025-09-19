import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/products/presentation/pages/product_list_page.dart';
import '../../features/products/presentation/pages/products_detail_page.dart';
import '../../headers.dart';

import '../../features/auth/presentation/pages/onboarding_page.dart'; // 👈 Add this

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding', // 👈 Start from here
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: AppRouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: AppRouteNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRouteNames.home,
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/product/:id',
        name: AppRouteNames.productDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailPage(productId: id);
        },
      ),
    ],
  );
});

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASHSCREEN,
      page: () => SplashscreenScreen(),
      binding: SplashscreenControllerBinding(),
    ),
    GetPage(
      name: Routes.SHARED,
      page: () => const SharedScreen(),
      binding: SharedControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => RegistrationScreen(),
      binding: RegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.RELAWAN,
      page: () => RelawanScreen(),
      binding: RelawanControllerBinding(),
    ),
    GetPage(
      name: Routes.NOTIFIKASI,
      page: () => NotifikasiScreen(),
      binding: NotifikasiControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFIL,
      page: () => ProfilScreen(),
      binding: ProfilControllerBinding(),
    ),
    GetPage(
      name: Routes.HOTLINE,
      page: () => HotlineScreen(),
      binding: HotlineControllerBinding(),
    ),
    GetPage(
      name: Routes.KUISIONER,
      page: () => KuisionerScreen(),
      binding: KuisionerControllerBinding(),
    ),
    GetPage(
      name: Routes.ROLE,
      page: () => const RoleScreen(),
      binding: RoleControllerBinding(),
    ),
    GetPage(
      name: Routes.CEK_DATA,
      page: () => CekDataScreen(),
      binding: CekDataControllerBinding(),
    ),
    GetPage(
      name: Routes.APPROVAL,
      page: () => ApprovalScreen(),
      binding: ApprovalControllerBinding(),
    ),
    GetPage(
      name: Routes.LUPA_PASSWORD,
      page: () => LupaPasswordScreen(),
      binding: LupaPasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.TIMSES,
      page: () => TimsesScreen(),
      binding: TimsesControllerBinding(),
    ),
    GetPage(
      name: Routes.SUMMARY_DATA,
      page: () => const SummaryDataScreen(),
      binding: SummaryDataControllerBinding(),
    ),
    GetPage(
      name: Routes.PENGUMUMAN,
      page: () => const PengumumanScreen(),
      binding: PengumumanControllerBinding(),
    ),
  ];
}

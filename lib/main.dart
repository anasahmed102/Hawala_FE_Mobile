import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawala/features/auth/prenstation/cubit/auth_cubit.dart';
import 'package:hawala/features/customer/presentation/cubit/cubit/add_update_delete_customer_cubit.dart';
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart';
import 'package:hawala/features/hawala/presentation/cubit/cubit/hawala_add_update_delete_cubit.dart';
import 'package:hawala/features/hawala/presentation/cubit/hawala_cubit.dart';
import 'package:hawala/firebase_options.dart';
import 'package:hawala/initilize.dart';
import 'package:hawala/localization/localizations_consttansts.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/connection_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/logger.dart';
import 'package:hawala/shared/responsive.dart';
import 'package:hawala/splash_screen.dart';
import 'package:hawala/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await preInitializations();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocprovider(),
      child: MultiProvider(
        providers: _providers(),
        child: Consumer<AppConfigurationService>(
          builder: (context, value, child) {
            return MaterialApp(
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              locale: getLocale(value.language),
              themeMode: value.themeMode(),
              theme: ThemeApp.lightTheme(context),
              darkTheme: ThemeApp.darkTheme(),
              debugShowCheckedModeBanner: false,
              navigatorKey: getItClient<AppConfigurationService>().navigatorKey,
              home: const SplashScreen(),
              builder: (context, child) {
                Responsive.init(
                  context,
                  designSize: const Size(414, 896),
                );

                return child!;
              },
            );
          },
        ),
      ),
    );
  }

  _blocprovider() {
    return [
      BlocProvider<AuthCubit>(
          create: (BuildContext context) => getItClient<AuthCubit>()),
      BlocProvider<CustomersCubit>(
          create: (BuildContext context) => getItClient<CustomersCubit>()),
      BlocProvider<AddUpdateDeleteCustomerCubit>(
          create: (BuildContext context) =>
              getItClient<AddUpdateDeleteCustomerCubit>()),
      BlocProvider<HawalaCubit>(
          create: (BuildContext context) => getItClient<HawalaCubit>()),
      BlocProvider<HawalaAddUpdateDeleteCubit>(
          create: (BuildContext context) =>
              getItClient<HawalaAddUpdateDeleteCubit>()),
    ];
  }

  _providers() {
    return [
      ChangeNotifierProvider(create: (_) => getItClient<ProfileNotifier>()),
      ChangeNotifierProvider(create: (_) => getItClient<ConnectionService>()),
      ChangeNotifierProvider(
          create: (_) => getItClient<AppConfigurationService>()),
    ];
  }

  Widget _builder(BuildContext context, Widget? child) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.1)),
      child: Builder(builder: (context) {
        Responsive.init(context, designSize: const Size(414, 896));

        return Consumer<ConnectionService>(builder: (context, connection, _) {
          bool isInternetConnected = connection.isConnected == false &&
              getItClient<AppConfigurationService>().workOnlyOnline &&
              // UserPermissions.i.workOnlineOnly == true &&
              kReleaseMode;

          getItClient<AppConfigurationService>().stopWorking &&
              // UserPermissions.i.limitUsage == true &&
              kReleaseMode;

          logger("show $isInternetConnected ${connection.isConnected}");
          return const Stack(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     closeKeyBoard(context);
              //   },
              //   child: child ?? const SizedBox(),
              // ),
              // if (isInternetConnected) const NoInterNetScreen(),
              // if (isStopWorking) const StopWorkingScreen(),
              // AnimatedContainer(
              //     margin: EdgeInsets.only(
              //         top: MediaQuery.of(context).viewPadding.top),
              //     width: context.width,
              //     duration: const Duration(seconds: 1),
              //     height: connection.isConnected ? 2 : 2,
              //     curve: Curves.ease,
              //     color: connection.isConnected ? Colors.green : Colors.red),
            ],
          );
        });
      }),
    );
  }
}

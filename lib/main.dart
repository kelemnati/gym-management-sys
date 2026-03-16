import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/internet_connectivity/connectivity_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/members/presentation/bloc/member_bloc.dart';
import 'features/classes/presentation/bloc/class_bloc.dart';
import 'features/equipment/presentation/bloc/equipment_bloc.dart';
import 'features/payments/presentation/bloc/payment_bloc.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/trainers/presentation/bloc/trainer_bloc.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ConnectivityCubit>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<MemberBloc>()),
        BlocProvider(create: (_) => di.sl<ClassBloc>()),
        BlocProvider(create: (_) => di.sl<EquipmentBloc>()),
        BlocProvider(create: (_) => di.sl<PaymentBloc>()),
        BlocProvider(create: (_) => di.sl<AttendanceBloc>()),
        BlocProvider(create: (_) => di.sl<TrainerBloc>()),
        BlocProvider(create: (_) => di.sl<NotificationBloc>()),
      ],
      child: MaterialApp(
        title: 'Gym Management',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}

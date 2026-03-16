import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../services/session_manager.dart';
import '../events/app_event_bus.dart';
import '../internet_connectivity/connectivity_service.dart';
import '../internet_connectivity/connectivity_cubit.dart';
import '../network/network_info.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/members/data/datasources/member_remote_data_source.dart';
import '../../features/members/data/repositories/member_repository_impl.dart';
import '../../features/members/domain/repositories/member_repository.dart';
import '../../features/members/domain/usecases/get_members_usecase.dart';
import '../../features/members/domain/usecases/add_member_usecase.dart';
import '../../features/members/presentation/bloc/member_bloc.dart';
import '../../features/classes/data/datasources/class_remote_data_source.dart';
import '../../features/classes/data/repositories/class_repository_impl.dart';
import '../../features/classes/domain/repositories/class_repository.dart';
import '../../features/classes/domain/usecases/get_classes_usecase.dart';
import '../../features/classes/domain/usecases/add_class_usecase.dart';
import '../../features/classes/presentation/bloc/class_bloc.dart';
import '../../features/equipment/data/datasources/equipment_remote_data_source.dart';
import '../../features/equipment/data/repositories/equipment_repository_impl.dart';
import '../../features/equipment/domain/repositories/equipment_repository.dart';
import '../../features/equipment/domain/usecases/get_equipment_usecase.dart';
import '../../features/equipment/domain/usecases/add_equipment_usecase.dart';
import '../../features/equipment/domain/usecases/update_equipment_status_usecase.dart';
import '../../features/equipment/presentation/bloc/equipment_bloc.dart';
import '../../features/payments/data/datasources/payment_remote_data_source.dart';
import '../../features/payments/data/repositories/payment_repository_impl.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';
import '../../features/payments/domain/usecases/payment_usecases.dart';
import '../../features/payments/presentation/bloc/payment_bloc.dart';
import '../../features/attendance/data/datasources/attendance_remote_data_source.dart';
import '../../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance/domain/repositories/attendance_repository.dart';
import '../../features/attendance/domain/usecases/attendance_usecases.dart';
import '../../features/attendance/presentation/bloc/attendance_bloc.dart';
import '../../features/trainers/data/datasources/trainer_remote_data_source.dart';
import '../../features/trainers/data/repositories/trainer_repository_impl.dart';
import '../../features/trainers/domain/repositories/trainer_repository.dart';
import '../../features/trainers/domain/usecases/trainer_usecases.dart';
import '../../features/trainers/presentation/bloc/trainer_bloc.dart';
import '../../features/notifications/data/datasources/notification_remote_data_source.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../../features/notifications/domain/usecases/notification_usecases.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core services
  sl.registerLazySingleton<SessionManager>(() => SessionManager());
  sl.registerLazySingleton<AppEventBus>(() => AppEventBus());
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory(() => ConnectivityCubit(sl()));

  // Dio
  sl.registerLazySingleton(
      () => Dio(BaseOptions(baseUrl: 'https://api.example.com')));

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));

  // Members
  sl.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<MemberRepository>(
      () => MemberRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetMembersUseCase(sl()));
  sl.registerLazySingleton(() => AddMemberUseCase(sl()));
  sl.registerFactory(() => MemberBloc(sl(), sl()));

  // Classes
  sl.registerLazySingleton<ClassRemoteDataSource>(
      () => ClassRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ClassRepository>(
      () => ClassRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetClassesUseCase(sl()));
  sl.registerLazySingleton(() => AddClassUseCase(sl()));
  sl.registerFactory(() => ClassBloc(sl(), sl()));

  // Equipment
  sl.registerLazySingleton<EquipmentRemoteDataSource>(
      () => EquipmentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<EquipmentRepository>(
      () => EquipmentRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetEquipmentUseCase(sl()));
  sl.registerLazySingleton(() => AddEquipmentUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEquipmentStatusUseCase(sl()));
  sl.registerFactory(() => EquipmentBloc(sl(), sl(), sl()));

  // Payments
  sl.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetPaymentsUseCase(sl()));
  sl.registerLazySingleton(() => AddPaymentUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentsByMemberUseCase(sl()));
  sl.registerFactory(() => PaymentBloc(sl(), sl(), sl()));

  // Attendance
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AttendanceRepository>(
      () => AttendanceRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => MarkAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendanceByClassUseCase(sl()));
  sl.registerFactory(() => AttendanceBloc(sl(), sl(), sl()));

  // Trainers
  sl.registerLazySingleton<TrainerRemoteDataSource>(
      () => TrainerRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<TrainerRepository>(
      () => TrainerRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetTrainersUseCase(sl()));
  sl.registerLazySingleton(() => AddTrainerUseCase(sl()));
  sl.registerFactory(() => TrainerBloc(sl(), sl()));

  // Notifications
  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => SendNotificationUseCase(sl()));
  sl.registerFactory(() => NotificationBloc(sl(), sl()));
}

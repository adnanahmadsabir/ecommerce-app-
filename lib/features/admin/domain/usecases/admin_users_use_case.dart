import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/features/admin/domain/repos/admin_users_repo.dart';

class AdminUsersUseCase {
  final AdminUsersRepo adminUsersRepo;
  AdminUsersUseCase(this.adminUsersRepo);

  Future<List<User?>> get() async => await adminUsersRepo.get() ?? [];
}

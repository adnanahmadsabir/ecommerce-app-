import 'package:clothes_app/data/repos/file_repo_impl.dart';
import 'package:clothes_app/data/repos/item_repo_impl.dart';
import 'package:clothes_app/data/repos/login_repo_impl.dart';
import 'package:clothes_app/data/services/api_service.dart';
import 'package:clothes_app/data/services/file_service.dart';
import 'package:clothes_app/data/services/pref_service.dart';
import 'package:clothes_app/domain/repos/file_repo.dart';
import 'package:clothes_app/domain/repos/item_repo.dart';
import 'package:clothes_app/domain/repos/login_repo.dart';
import 'package:clothes_app/domain/usecases/item_use_case.dart';
import 'package:clothes_app/domain/usecases/login_use_case.dart';
import 'package:clothes_app/domain/usecases/sign_up_use_case.dart';
import 'package:clothes_app/features/admin/data/repos/admin_users_repo_impl.dart';
import 'package:clothes_app/features/admin/domain/repos/admin_users_repo.dart';
import 'package:clothes_app/features/admin/domain/usecases/admin_users_use_case.dart';
import 'package:clothes_app/features/admin/ui/providers/admin_users_provider.dart';
import 'package:clothes_app/features/admin/ui/providers/upload_item_provider.dart';
import 'package:clothes_app/features/users/data/repos/sign_up_repo_impl.dart';
import 'package:clothes_app/features/users/domain/repos/sign_up_repo.dart';
import 'package:clothes_app/ui/providers/auth_provider.dart';
import 'package:clothes_app/ui/providers/file_provider.dart';
import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:clothes_app/ui/providers/nav_bar_provider.dart';
import 'package:clothes_app/ui/providers/search_bar_provider.dart';
import 'package:clothes_app/ui/providers/theme_provider.dart';

class Injection {
  /// services
  final _apiService = ApiService();
  final _prefService = PrefService();
  final _fileService = FileService();

  /// repositories
  LoginRepo get _loginRepo => LoginRepoImpl(_apiService, _prefService);
  SignUpRepo get _signUpRepo => SignUpRepoImpl(_prefService, _apiService);
  ItemRepo get _itemRepo => ItemRepoImpl(_apiService);
  FileRepo get _fileRepo => FileRepoImpl(_fileService);
  AdminUsersRepo get _adminUsersRepo => AdminUsersRepoImpl(_apiService);

  /// usecases
  LoginUseCase get _loginUseCase => LoginUseCase(_loginRepo);
  SignUpUseCase get _signUpUseCase => SignUpUseCase(_signUpRepo);
  ItemUseCase get _itemUseCase => ItemUseCase(_itemRepo);
  AdminUsersUseCase get _adminUsersUseCase =>
      AdminUsersUseCase(_adminUsersRepo);

  /// providers
  AuthProvider get authProvider => AuthProvider(_loginUseCase, _signUpUseCase);
  ThemeProvider get themeProvider => ThemeProvider(_prefService);
  AdminUsersProvider get adminUsersProvider =>
      AdminUsersProvider(_adminUsersUseCase);
  UploadItemProvider get uploadItemProvider => UploadItemProvider(_itemUseCase);
  SearchBarProvider get searchBarProvider => SearchBarProvider();
  ItemProvider get itemProvider => ItemProvider(_itemUseCase);
  NavBarProvider get navBarProvider => NavBarProvider();
  FileProvider get fileProvider => FileProvider(_fileRepo);
}

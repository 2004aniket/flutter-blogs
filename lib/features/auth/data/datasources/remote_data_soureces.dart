import 'package:blog/core/exceptions/serverexception.dart';
import 'package:blog/features/auth/data/model/UserModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class remoteDataSource {
  Session? get CurrentUser;
  Future<Usermodel?> getCurrentUser();
  Future<Usermodel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Usermodel> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class RemoteDataSoureceImpl implements remoteDataSource {
  final SupabaseClient supabaseClient;
  RemoteDataSoureceImpl(this.supabaseClient);

  @override
  Future<Usermodel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      return Usermodel.fromJson(response.user!.toJson());
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }

  @override
  Future<Usermodel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});

      if (response.user == null) {
        throw Serverexception("User is null");
      }
      return Usermodel.fromJson(response.user!.toJson());
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }

  @override
  // TODO: implement getCurrentUser
  Session? get CurrentUser => supabaseClient.auth.currentSession;

  @override
  Future<Usermodel?> getCurrentUser() async {
    try {
      if (CurrentUser != null) {
        final res = await supabaseClient
            .from("profiles")
            .select()
            .eq("id", CurrentUser!.user.id);
        return Usermodel.fromJson(res.first);
      }

      return null;
    } catch (e) {
      throw Serverexception(e.toString());
    }
  }
}

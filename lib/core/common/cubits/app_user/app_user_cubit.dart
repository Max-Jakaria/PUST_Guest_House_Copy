import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(MyUser? user){
    if(user == null){
      emit(AppUserInitial());
    }else{
      emit(AppUserSignedIn(user: user));
    }
  }
}

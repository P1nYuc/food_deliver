import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
 

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;
  AuthenticationBloc({
    required this.userRepository,
  }) 
  : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user){
      add(AuthenticationUserChange(user));
    });
    on<AuthenticationUserChange>((event, emit) {
      if(event.user != MyUser.empty){//如果 event.user 不是空的，則發出一個已驗證的狀態。 
        emit(AuthenticationState.authenticated(event.user!));//emit:主要作用是將新的狀態傳遞給狀態流（state stream），這樣 UI 層就能夠訂閱並響應這些狀態變化。
      }else{//如果 event.user 是空的，則發出一個未驗證的狀態。
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {//關閉 _userSubscription。
    _userSubscription.cancel();
    return super.close();
  }

}

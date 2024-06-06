part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }
//enum 定義了身份驗證狀態的三種可能值：
// authenticated：已驗證
// unauthenticated：未驗證
// unknown：未知


class AuthenticationState  extends Equatable{//Equatable 是一個用於比較對象的庫。
  const AuthenticationState._({//_ == private
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  final AuthenticationStatus status;
  final MyUser? user;

  const AuthenticationState.unknown() : this._();//當 AuthenticationState.unknown() 被調用時，它實際上調用的是 AuthenticationState._()。

  const AuthenticationState.authenticated(MyUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);//當 AuthenticationState.authenticated() 被調用時，它實際上調用的是 AuthenticationState._()。

  const AuthenticationState.unauthenticated() 
      : this._(status: AuthenticationStatus.unauthenticated);//當 AuthenticationState.unauthenticated() 被調用時，它實際上調用的是 AuthenticationState._()。

  @override
  List<Object> get props => [status, user!];//依據 status 和 user 的值來比較 AuthenticationState 對象。
}

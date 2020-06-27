import 'auth.dart';

///this class is the input for the Block. Typically, this event is a UI event such as a Button that is pressed or loads a page.
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class SignInSubmitEvent extends AuthEvent{
  /// Do something with this event
  final String userName;
  final String password;

  SignInSubmitEvent({this.userName, this.password});

  @override
  String toString() => 'SignInSubmitEvent { userName: $userName, password: $password }';
}

import 'auth.dart';

///this class is output from Bloc. Components of the UI can be defined as states and can be redrawn 
///according to their current state.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {
  ///this state when is no event
}

class ProcessState extends AuthState {
  /// Do something with this state

}

class SignInCompletedState extends AuthState {
  /// Do something with this state

}

class SignUpCompletedState extends AuthState {
    /// Do something with this state

}

class SignOutCompletedState extends AuthState {
    /// Do something with this state

}

class FailureState extends AuthState {
    /// Do something with this state
  final String error;

  const FailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Failure { error: $error }';
}



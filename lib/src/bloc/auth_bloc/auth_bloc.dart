import 'package:bigbox_flutter/src/bloc/auth_bloc/auth_event.dart';
import 'package:bigbox_flutter/src/bloc/auth_bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

///this class as a component that changes Streaming from the event to Streaming which changes the status
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final ApiService apiService;

  // AuthBloc(this.apiService);

   @override
  AuthState get initialState => InitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) {
    /// Do something event state
    if(event is SignInSubmitEvent){
      try{

      }catch(error){

      }
    }
  }
}
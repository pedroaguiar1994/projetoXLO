import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/button_state.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';
import 'package:xlo/validators/login_validator.dart';

class LoginBloc with LogindValidator{

  final BehaviorSubject<LoginBlocState> _stateController =
   BehaviorSubject<LoginBlocState>.seeded(LoginBlocState(LoginState.IDLE));
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _senhaController = BehaviorSubject<String>();

  Function(String) get changedEmail => _emailController.sink.add;
  Function(String) get changedSenha => _senhaController.sink.add;

  Stream<LoginBlocState> get  outState => _stateController.stream;

  Stream<FieldState> get outEmail => Rx.combineLatest2(
    _emailController.stream.transform(emailValidator), outState, (a, b){
    a.enabled = b.state !=LoginState.LOADING;
    return a;
  });
  
  Stream<FieldState> get outSenha => Rx.combineLatest2(
    _senhaController.stream.transform(senhalValidator), outState, (a,b){
      a.enabled = b.state !=LoginState.LOADING;
    return a;
    });
  
  Stream<ButtonState> get outLoginButton => Rx.combineLatest3(
    outEmail, outSenha, outState, (a ,b , c){
      return ButtonState(
        loading: c.state == LoginState.LOADING,
        enabled: a.error == null && b.error == null && c.state != LoginState.LOADING

      );
    }
  );
  Future<bool>loginWithEmail()async{
    _stateController.add(LoginBlocState(LoginState.LOADING));

    await Future.delayed(Duration(seconds:  3));

    _stateController.add(LoginBlocState(LoginState.DONE));
    return true;
  }

 Future<bool> loginWithFacebook() async{
    _stateController.add(LoginBlocState(LoginState.LOADING_FACE));
    await Future.delayed(Duration(seconds: 3));

    _stateController.add(LoginBlocState(LoginState.DONE));
    return true;
  }

  void dispose(){
    _stateController.close();
     _emailController.close();
     _senhaController.close();
  }
}
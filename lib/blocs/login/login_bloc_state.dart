enum LoginState{IDLE, LOADING , LOADING_FACE,ERROR, DONE}
class LoginBlocState{

  LoginBlocState(this.state, {this.errorMensage});
  
  LoginState state;
  String errorMensage;
}
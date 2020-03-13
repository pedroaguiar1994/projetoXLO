import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/signup_bloc.dart';
import 'package:xlo/screens/login/signUp/widgets/field_title.dart';
import 'package:xlo/screens/login/signUp/widgets/senha_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  SignUpBloc _signUpBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cadastrar"),
      ),
      body: Form(
        child: StreamBuilder<SignUpBlocState>(
          stream: _signUpBloc.outState,
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: <Widget>[
                const FieldTitle(
                  title: 'Apelido',
                  subtitle: 'Como aparecerar em seus anuncios.',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Exemplo: Pedro H."
                  ),
                  validator: (text){
                    if(text.length < 6)
                    return 'Apelido muito curto';
                    return null;
                  },
                  onSaved: _signUpBloc.setName,
                  enabled: snapshot.data.state != SignUpState.LOADING,
                ),
                const SizedBox(height: 26,),
                const FieldTitle(
                  title: 'E-mail',
                  subtitle: 'Enviaremos um e-mail de confirmaçao.',
                ),
                 TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (text){
                    if(text.length < 6 || !text.contains("@"))
                    return 'E-mail invalido';
                    return null;
                  },
                  onSaved: _signUpBloc.setEmail,
                   enabled: snapshot.data.state != SignUpState.LOADING,
                ),
                const SizedBox(height: 25,),
                const FieldTitle(
                  title: 'Senha',
                  subtitle: 'Use letras, numero e caracteres especiais.',
                ),
                SenhaField(
                  onSaved: _signUpBloc.setPassrword,
                   enabled: snapshot.data.state != SignUpState.LOADING,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  height: 50,
                  child: RaisedButton(
                    color: Colors.pink,
                    disabledColor: Colors.pink.withAlpha(150),
                    child: snapshot.data.state == SignUpState.LOADING ? 
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ) :
                    Text("Cadastra-se",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    onPressed: snapshot.data.state != SignUpState.LOADING ? _signUp : null,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void _signUp(){
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();

      _signUpBloc.signUp();
      
    }
  }
}
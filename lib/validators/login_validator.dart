import 'dart:async';

import 'package:xlo/blocs/login/field_state.dart';

class LogindValidator{

  final StreamTransformer<String, FieldState>emailValidator = 
  StreamTransformer<String, FieldState>.fromHandlers(
    handleData: (email , sink){
      const Pattern pattern = r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
      final RegExp regex = RegExp(pattern);
      if(email.isEmpty)
      sink.add(FieldState(error: 'Campo obrigatiorio'));
      else if(!regex.hasMatch(email))
        sink.add(FieldState(error: 'Email invalido'));
      else
        sink.add(FieldState());
    }
  );
   final StreamTransformer<String, FieldState>senhalValidator = 
  StreamTransformer<String, FieldState>.fromHandlers(
    handleData: (senha , sink){
      if(senha.isEmpty)
      sink.add(FieldState(error: 'Campo obrigatiorio'));
      else
        sink.add(FieldState());
    }
  );
}
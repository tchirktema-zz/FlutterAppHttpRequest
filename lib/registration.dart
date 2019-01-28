import 'package:flutter/material.dart';

//import validation plugin
import 'package:validate/validate.dart';
// http request plugin
import 'package:http/http.dart' as http;


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}


class _RegistrationData{
  String nom = '';
  String prenom = '';
  String email = '';
  String sexe = '';
  String password = '';
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();




  _RegistrationData _data = new _RegistrationData();

  var url = 'http://192.168.43.25:8000/api/create.php';
  var success = 0;
  var message = '';
//  email validate function
  String _validateEmail(String value) {
    try{
      Validate.isEmail(value);
    }catch(e){
      return 'Adresse e-mail invalide';
    }

    return null;
  }


  // Add validate password function.
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'Le mot de passe est trop court (8 caractères minimum)';
    }
    return null;
  }

  String _validateEmptyField(String value){
    if(value.length == 0){
      return 'Ce champ est obligatoire';
    }
    return null;
  }


   submit() async{
    if(this._formkey.currentState.validate()){
      _formkey.currentState.save();

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');

      http.post(url,body: {
        "nom": _data.nom,
        "prenom": _data.prenom,
        "email": _data.email,
        "password": _data.password
      }).then((response) {
        this.success = response.statusCode;
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      });

      if(this.success == 200){
        print("Response success: ${this.success}");
        message = "Votre inscription c'est éffectué avec succès";
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20.0),
      child: new Form(
        key: this._formkey,
        child: ListView(
          children: <Widget>[
            new Text(
                '${this.message}',
                style: TextStyle(
                    fontSize:20.0,
                    color:Colors.green
                )
            ),

            new TextFormField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Nom de famille",
                labelText: 'Entrer votre nom de famille'
              ),
              validator: this._validateEmptyField,
              onSaved: (String value){
                this._data.nom = value;
              },
            ),

            new TextFormField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Prenom",
                  labelText: 'Entrer votre prenom'
              ),
              validator: this._validateEmptyField,
              onSaved: (String value){
                this._data.prenom = value;
              },
            ),

            new TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  hintText: "you@exemple.com",
                  labelText: 'Entrer votre adresse email'
              ),
              validator: this._validateEmail,
              onSaved: (String value){
                this._data.email = value;
              },
            ),

            new TextFormField(
              obscureText: true,
              decoration: new InputDecoration(
                  hintText: "Password",
                  labelText: 'Entrer votre mot de passe'
              ),
              validator: this._validatePassword,
              onSaved: (String value){
                this._data.password = value;
              },
            ),


            new Container(//button
              width: screenSize.width,
              child: new RaisedButton(
                child: new Text(
                  "Je m'inscris",
                  style: new TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: this.submit,
                color: Colors.blue,
              ),
              margin: new EdgeInsets.only(
                top: 20.0
              ),
            )
          ],
        )
      ),
    );
  }
}

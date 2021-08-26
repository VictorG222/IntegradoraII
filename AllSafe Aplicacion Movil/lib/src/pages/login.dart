import 'package:flutter/material.dart';
import 'package:allsafe_appmobile/src/provider/login_provider.dart';
import 'package:get/get.dart';

void main() {
   runApp(Login());
}

class Login extends StatelessWidget {
  double padd = 200;
  final _loginProvider = Get.find<LoginProvider>();

  @override
  Widget build(BuildContext context) {
    final double _mediaSize = MediaQuery.of(context).size.height;
    return Material(
	child: Stack(children: [
	_logoAllsafe(),
	login(),
	Center(
		child: Padding(
		padding: EdgeInsets.fromLTRB(0, _mediaSize * 0.35, 0, 0),
		child: MyCustomForm(login_provider: _loginProvider),
		),
	),
	Padding(
		padding: EdgeInsets.fromLTRB(0, _mediaSize * 0.25, 0, 0),
		child: loginButton(),
	),
	]),
	);
  }
}

class _logoAllsafe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0.04 * _mediaSize, 0, 0.7 * _mediaSize),
      child: Stack(children: [
        Container(
          child: Image.asset(
            'Allsafe_Logo.png',
            width: 10 * _mediaSize,
            height: 10 * _mediaSize,
          ),
        ),
      ]),
    );
  }
}

class logintext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(0, 0.01 * _mediaSize, 0, 0.39 * _mediaSize),
          child: Text(
            "Inicio de sesión",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold'),
          ),
        ));
  }
}

class loginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
          child: Text(
            "Iniciar Sesión",
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                horizontal: _mediaSize * 0.12,
                vertical: _mediaSize * 0.04,
              )),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(13, 78, 133, 1)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(13, 78, 133, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.black, width: 2.0)))),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  LoginProvider loginProvider;
  MyCustomForm({required this.loginProvider});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _loginProvider = Get.find<LoginProvider>();
  @override
  Widget build(
    BuildContext context,
  ) {
    final double _mediaSize = MediaQuery.of(context).size.height;
    TextEditingController emailController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: _mediaSize * 0.35,
          child: TextFormField(
            onChanged: (data) {
              _loginProvider.usuario.correo = data;
            },
            decoration: InputDecoration(
              suffixIcon:
                  Icon(Icons.email, color: Color.fromRGBO(13, 78, 133, 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  )),
              hintText: 'Ingresar su correo'),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: _mediaSize * 0.04),
          child: Container(
            width: _mediaSize * 0.35,
            child: TextFormField(
              onChanged: (data) {
                _loginProvider.usuario.password = data;
              },
              obscureText: true,
              decoration: InputDecoration(
                  suffixIcon:
                      Icon(Icons.lock, color: Color.fromRGBO(13, 78, 133, 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                  hintText: 'Ingresar su contraseña')),
            ),
          ),
        ),
      ],
    );
  }
}
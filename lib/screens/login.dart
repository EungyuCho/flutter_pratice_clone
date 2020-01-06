import 'package:flutter/material.dart';
import 'package:practice_clone1/data/join_or_login.dart';
import 'package:practice_clone1/helper/login_background.dart';
import 'package:provider/provider.dart';
class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height*0.1,
              ),
                GestureDetector(
                    onTap: (){
                      JoinOrLogin joinOrLogin = Provider.of<JoinOrLogin>(context);
                      joinOrLogin.toggle();
                    },
                    child: Text("Don't Have an Account? Create One")),
                Container(
                  height: size.height*0.05,
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget get _logoImage => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/200'),
        ),
      ),
    ),
  );

  Widget _inputForm(Size size) => Padding(
      padding: EdgeInsets.all(size.width*0.05),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12, right: 12, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: "Email",
                    ),
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please input current Email.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: "password"
                    ),
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please input current Password.";
                      }
                      return null;
                    },
                  ),
                  Container(height: 8,),
                  Text('Forgot Password'),
                ],
              )),
        ),
      ),
    );

  Widget _authButton(Size size) => Positioned(
      left: size.width*0.15,
      right: size.width*0.15,
      bottom: 0,
      child: SizedBox(
          height: 50,
          child: RaisedButton(
          child: Text('Login', style: TextStyle(fontSize: 20, color: Colors.white),),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          onPressed: (){
            if(_formKey.currentState.validate()){
              print(_emailController.text.toString());
              print(_passwordController.text.toString());
            }
          })
        ,),
    );

}
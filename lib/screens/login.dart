import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobcom/constants.dart';
import 'package:mobcom/widgets/customInput.dart';
import 'package:mobcom/widgets/custombuttons.dart';
import 'package:mobcom/widgets/register.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: Text("Close Dialog")),
            ],
          );
        }
    );
  }

  Future <String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail, password: _loginPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async{
    // set form state to loading
    setState(() {
      _loginFormLoading = true;
    });
    // call create account method
    String? _loginAccountFeedback = await  _loginAccount();
    //if is not null, display error.
    if(_loginAccountFeedback != null){
      _alertDialogBuilder(_loginAccountFeedback);
      // set form to regular state. Not loading.
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  bool _loginFormLoading = false;

  //form input field values
  String _loginEmail = "";
  String _loginPassword ="";

  // focus nodes for input fields
  FocusNode? _passwordFocusNode;

  @override

  void initState(){
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose(){
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "Welcome, Log in to your account",
                    style: Constants.boldHeading,
                    textAlign: TextAlign.center,

                  ),
                ),
                Container(
                   child: Column(
                     children: [
                       CustomInput(
                         hintText: "Email",
                         onChanged: (value){
                           _loginEmail = value;
                         },
                         onSubmitted: (value){
                           _passwordFocusNode!.requestFocus();
                         },
                         textInputAction:TextInputAction.next,
                       ),
                       CustomInput(
                         hintText: "password",
                         onChanged: (value){
                           _loginPassword = value;
                         },
                         focusNode: _passwordFocusNode,
                         isPasswordField: true,
                         onSubmitted: (value){
                           _submitForm();
                         },
                       ),
                       CustomBtn(
                         text: "Log in",
                         onPressed: (){
                           _submitForm();
                         },
                         isLoading: _loginFormLoading,
                        ),
                     ],
                   ),
                ),
                 CustomBtn(
                text: "Create An Account",
                onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
               ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

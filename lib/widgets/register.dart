import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobcom/constants.dart';
import 'package:mobcom/widgets/customInput.dart';
import 'package:mobcom/widgets/custombuttons.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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

  Future <String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail, password: _registerPassword,
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
       _registerFormLoading = true;
    });
    // call create account method
    String? _createAccountFeedback = await  _createAccount();
    //if is not null, display error.
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback);
      // set form to regular state. Not loading.
      setState(() {
        _registerFormLoading = false;
      });
    }else{
      Navigator.pop(context);
    }

  }

 bool _registerFormLoading = false;

  //form input field values
  String _registerEmail = "";
  String _registerPassword ="";

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
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "Create A new Account here",
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
                            _registerEmail = value;
                          },
                          onSubmitted: (value){
                            _passwordFocusNode!.requestFocus();
                          },
                          textInputAction:TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "password",
                            onChanged: (value){
                              _registerPassword = value;
                            },
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          onSubmitted: (value){
                            _submitForm();
                          },
                        ),
                        CustomBtn(
                          text: "Create New Account",
                          onPressed: (){
                             _submitForm();
                          },
                          isLoading: _registerFormLoading,
                        ),
                        //CircularProgressIndicator(),
                      ],
                    )
                ),
                CustomBtn(
                  text: "Back to Login",
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}

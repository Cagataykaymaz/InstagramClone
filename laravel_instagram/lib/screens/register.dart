import 'package:flutter/material.dart';
import 'package:laravel_instagram/constant.dart';
import 'package:laravel_instagram/models/api_response.dart';
import 'package:laravel_instagram/models/user.dart';
import 'package:laravel_instagram/screens/home.dart';
import 'package:laravel_instagram/screens/login.dart';
import 'package:laravel_instagram/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading=false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
   
  void _registerUser() async {
    ApiResponse response = await register(nameController.text, emailController.text,passwordController.text);
    if(response.error==null){
   _saveAndRedirectToHome(response.data as User?);
    }
    else{
      setState(() {
        loading=!loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
        ));
    }
  }

  void _saveAndRedirectToHome(User? user) async{
SharedPreferences pref=await SharedPreferences.getInstance();
await pref.setString('token', user?.token ?? '');
await pref.setInt('userId', user?.id ?? 0);
 Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 32),
          children: [
            TextFormField(
              controller: nameController,
              validator: (val)=>val!.isEmpty ?'Invalid name':null,
              decoration: kInputDecoration('Name'),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val)=>val!.isEmpty ?'Invalid email address':null,
              decoration: kInputDecoration('Email'),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (val)=>val!.length < 6 ?'Required at least 6 chars ':null,
              decoration: kInputDecoration('Password'),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordConfirmController,
              obscureText: true,
              validator: (val)=>val!=passwordController.text ?'Confirm password does not match':null,
              decoration: kInputDecoration('Confirm Password'),
            ),
            SizedBox(height: 20,),
            loading?
            Center(child: CircularProgressIndicator(),):
            kTextButton('Register', (){
              if(formKey.currentState!.validate()){
                setState(() {
                  loading=!loading;
                  _registerUser();
                });
              }
            }),
            SizedBox(height: 20,),
            kLoginRegisterHint('Already have an account?', 'Login', (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
            })
          ],
        ),
      ),
      
    );
  }
}
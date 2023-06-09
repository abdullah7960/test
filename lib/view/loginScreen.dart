import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        //appBar: AppBar(),
        body: Column(
          //mainAxisAlignment:MainAxisAlignment.center.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Text('Login',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
            
            ),
           const SizedBox(height: 28,),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Username',style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
                        TextFormField(
                          decoration:const InputDecoration(
                            hintText: "Type username",
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none
                          ),
                          
                        ),
                        const Divider(),
                        Text('Password',style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
                        TextFormField(
                          decoration:const InputDecoration(
                            hintText: "Type Password",
                            prefixIcon: Icon(Icons.lock),
                            border: InputBorder.none
                          ),
                          
                        ),
                        const Divider(),
                       const SizedBox(height: 28,),
                       const Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text('Forgot Password?')
                            ],
                          ),
                        ),
                        const SizedBox(height: 43,),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration:const BoxDecoration(
                            gradient: LinearGradient(colors:[Colors.red,Colors.black,Colors.green] )
                          ),
                          child:const Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),)),
                        ),
                        const SizedBox(height: 43,),
                        
                            const Center
                            (child: Text('Or Sign Up',style: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(height: 8,),
                           const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(Icons.facebook,size: 35,color: Colors.blue,),
                                SizedBox(width: 19,),
                                 Icon(Icons.person_off_outlined,size: 35,),
                                 SizedBox(width: 19,),
                                 Icon(Icons.gite_outlined,size: 35),
                              ],
                            ),
                            const SizedBox(height: 140,),
                            const Align(
                              alignment: Alignment.center,
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Or Sign Up Using',style: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold)),
                                  Text('Sign Up',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            
                            
                        
                      ],
                    ),
                  ],
                ),), 
            )
          ],
        ),
      ),
      );
    }
    }
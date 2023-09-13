import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../users/home_page.dart';
import 'bloc/auth_bloc.dart';
import 'mixin/auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(200),
                    child: Container(
                      decoration: const ShapeDecoration(
                        color: Color(0xF53841A9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(45),
                          ),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ]
                          ),
                          ListTile(
                            title: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Fill up your details to register.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 20),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Enter your name",
                                labelStyle: const TextStyle(
                                  color: Color(0xFF417BEA),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFF417BEA),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Enter your email",
                                labelStyle: const TextStyle(
                                  color: Color(0xFF417BEA),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFF417BEA),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Enter your password",
                                labelStyle: const TextStyle(
                                  color: Color(0xFF417BEA),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFF417BEA),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 150,bottom: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Color(0xFF417BEA)),
                              onPressed: () {
                                context.read<AuthBloc>().add(LoginWithEmailEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              },
                              child: const Text('Login', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Color(0xFF417BEA)),
                            onPressed: () {
                              context.read<AuthBloc>().add(SignUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text));
                            },
                            child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

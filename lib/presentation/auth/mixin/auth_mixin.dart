

import 'package:flutter/material.dart';

import '../auth.dart';

mixin HomeMixin on State<AuthPage>{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
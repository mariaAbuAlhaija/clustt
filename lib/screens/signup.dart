import 'package:clust/controllers/user_controller.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/text_field.dart' as txtField;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        textTheme: kIsWeb
            ? Theme.of(context).textTheme.copyWith(
                  labelMedium:
                      web.labelMedium(color: Palate.black.withOpacity(0.5)),
                )
            : Theme.of(context).textTheme.copyWith(
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                ),
      ),
      child: Scaffold(
        backgroundColor: Palate.black,
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, right: 30.w, left: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Logo().logo(),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        nameField(),
                        emailField(),
                        sizedBox(context, kIsWeb ? 30.h : 20.h),
                        passwordField(context),
                        submitButton(context),
                        sizedBox(context, 10.h),
                        options(context)
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText options(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: kIsWeb
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.bodySmall,
          text: ("Not a member? "),
          children: const [
            TextSpan(
                style: TextStyle(color: Palate.sand),
                text: kIsWeb ? "\nSign up" : "Sign up")
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Navigator.pop(context);
            }),
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 460,
          child: txtField.TextField(
            type: txtField.Type.password,
            controller: passwordController,
            hint: "Password",
            lable: "Password",
            forWhat: txtField.For.signin,
          ),
        ),
        sizedBox(context, 7.h),
        RichText(
          text: TextSpan(
              style: kIsWeb
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.labelSmall,
              text: ("Forget password?"),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pop(context);
                }),
        )
      ],
    );
  }

  Container emailField() {
    return Container(
      width: 460,
      child: txtField.TextField(
        type: txtField.Type.email,
        controller: emailController,
        hint: "Email",
        lable: "Email",
        forWhat: txtField.For.signin,
      ),
    );
  }

  Container nameField() {
    return Container(
      width: 460,
      child: txtField.TextField(
        type: txtField.Type.general,
        controller: nameController,
        hint: "Name",
        lable: "Name",
        forWhat: txtField.For.signup,
      ),
    );
  }

  SizedBox sizedBox(BuildContext context, height) {
    return SizedBox(height: height);
  }

  Padding submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: 60,
        width: 460,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String email = emailController.text;
              String password = passwordController.text;
              print("before");
              UserController().getByID(1).then((value) {
                print("during");
                Navigator.pushNamed(context, "/start");
              }).catchError((ex, stacktrace) {
                print("error");
                print(ex.toString());
                print(stacktrace);
              });
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              backgroundColor: MaterialStateProperty.all(
                  Palate.lighterBlack.withOpacity(0.48))),
          child: Text(
            "Sign In",
            style: kIsWeb
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

import 'package:clust/controllers/user_controller.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/chips.dart';
import 'package:clust/widgets/text_field.dart' as txtField;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clust/widgets/date_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

var fnameController = TextEditingController();
var lnameController = TextEditingController();
var dateController = TextEditingController();
var genderController;
var emailController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();
var selectedIndex = "";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.amberAccent,
        useMaterial3: true,
        textTheme: kIsWeb
            ? Theme.of(context).textTheme.copyWith(
                  labelMedium:
                      web.labelMedium(color: Palate.black.withOpacity(0.5)),
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                )
            : Theme.of(context).textTheme.copyWith(
                  bodySmall: mobile.bodySmall(
                    color: Palate.black.withOpacity(0.5),
                  ),
                ),
      ),
      child: Scaffold(
        backgroundColor: Palate.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, right: 30.w, left: 30.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // kIsWeb ? Logo().logo() :
                  sizedBoxH(context, 40.h),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          nameField(),
                          sizedBoxH(context, 20.h),
                          DatePicker(
                            dateController: dateController,
                          ),
                          sizedBoxH(context, 20.h),
                          Container(
                              width: 460,
                              child: Chips(selected: selectedIndex)),
                          sizedBoxH(context, 20.h),
                          emailField(),
                          sizedBoxH(context, 20.h),
                          passwordField(),
                          submitButton(context),
                          sizedBoxH(context, 10.h),
                          options(context),
                        ]),
                  ),
                ],
              ),
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
          text: ("Already a member? "),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, "/signin");
                  },
                style: TextStyle(color: Palate.sand),
                text: kIsWeb ? "\nSign in" : "Sign in"),
          ],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, "/signin");
            }),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          splitedFields(fnameController, "First name", "First name",
              txtField.Type.general, false),
          // sizedBoxW(context, 10.w),
          splitedFields(lnameController, "Last name", "Last name",
              txtField.Type.general, false),
        ],
      ),
    );
  }

  Container splitedFields(controller, hint, lable, type, confirm) {
    String confirmtxt = confirm ? passwordController.text : "h";
    print("pc= ${passwordController.text}");
    print("fn= ${fnameController.text}");
    print("ln= ${lnameController.text}");
    print("db= ${dateController.text}");
    print("e= ${emailController.text}");
    return Container(
      width: kIsWeb ? 225 : 170,
      child: txtField.TextField(
        type: type,
        controller: controller,
        hint: hint,
        lable: lable,
        forWhat: txtField.For.signup,
        confirmPassword: confirmtxt,
      ),
    );
  }

  Container passwordField() {
    return Container(
      width: 460,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          splitedFields(passwordController, "Password", "Password",
              txtField.Type.password, false),
          // sizedBoxW(context, 10.w),
          splitedFields(confirmPasswordController, "Confirm", "Confirm",
              txtField.Type.confirm, true),
        ],
      ),
    );
  }

  SizedBox sizedBoxH(BuildContext context, height) {
    return SizedBox(height: height);
  }

  SizedBox sizedBoxW(BuildContext context, width) {
    return SizedBox(width: width);
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
            "Sign Up",
            style: kIsWeb
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

// /////////////////////////
// class TextField extends StatefulWidget {
//   TextField({
//     super.key,
//     required this.type,
//     required this.controller,
//     required this.hint,
//     required this.lable,
//     this.forWhat = For.signup,
//     this.confirmPassword = "k",
//   });
//   Type type;
//   TextEditingController controller;
//   String hint;
//   String lable;
//   For forWhat;
//   String? confirmPassword;

//   @override
//   State<TextField> createState() => TtextFieldState();
// }

// class TtextFieldState extends State<TextField> {
//   var obscureText = true;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         lable(context),
//         SizedBox(
//           height: 15.h,
//         ),
//         TextFormField(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           validator:
//               widget.forWhat == For.signup ? validators() : signinValidators(),
//           controller: widget.controller,
//           decoration: decoration(context),
//           obscureText: isPassword ? obscureText : false,
//           keyboardType: keyboardType(),
//           onChanged: (value) => print(widget.controller.text),
//         ),
//       ],
//     );
//   }

//   Text lable(BuildContext context) => Text(widget.lable,
//       style: kIsWeb
//           ? Theme.of(context).textTheme.labelLarge
//           : Theme.of(context).textTheme.headlineSmall);

//   InputDecoration decoration(BuildContext context) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Palate.white,
//       hintText: widget.hint,
//       hintStyle: hintstyle(context),
//       contentPadding: padding(),
//       isDense: true,
//       suffixIcon: isPassword ? suffix() : null,
//       border: border(),
//       focusedBorder: focusedborder(),
//     );
//   }

//   TextStyle? hintstyle(BuildContext context) {
//     return kIsWeb
//         ? Theme.of(context).textTheme.labelMedium
//         : Theme.of(context).textTheme.bodySmall;
//   }

//   EdgeInsets padding() {
//     return const EdgeInsets.symmetric(vertical: 15, horizontal: 10);
//   }

//   OutlineInputBorder focusedborder() {
//     return OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: Colors.transparent, width: 0),
//         gapPadding: 20);
//   }

//   OutlineInputBorder border() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(color: Colors.transparent, width: 0),
//       gapPadding: 20,
//     );
//   }

//   FormFieldValidator<String> signinValidators() {
//     return FormBuilderValidators.compose([
//       FormBuilderValidators.required(),
//       isEmail
//           ? FormBuilderValidators.email()
//           : FormBuilderValidators.required(),
//     ]);
//   }

//   FormFieldValidator<String> validators() {
//     return FormBuilderValidators.compose([
//       FormBuilderValidators.required(),
//       isEmail
//           ? FormBuilderValidators.email()
//           : isPassword
//               ? customisedValidator
//               : isConfirm
//                   ? confirmValidator
//                   : FormBuilderValidators.required(),
//     ]);
//   }

//   String customisedValidator(value) {
//     if (!value!.contains(RegExp("(?=.*?[0-9])"))) {
//       return "Include one digit at least";
//     }
//     if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
//       return "Include one letter at least";
//     }
//     if (!value.contains(RegExp(".{8,}"))) {
//       return "Include more than 8 characters";
//     }

//     return "";
//   }

//   String confirmValidator(value) {
//     if (value != passwordController.text) {
//       print("v=$value c=${passwordController.text}");
//       print("pc= ${passwordController.text}");
//       print("fn= ${fnameController.text}");
//       print("ln= ${lnameController.text}");
//       print("db= ${dateController.text}");
//       print("e= ${emailController.text}");
//       return "Passwords must match";
//     }

//     return "";
//   }

//   InkWell suffix() {
//     return InkWell(
//         onTap: () {
//           setState(() {
//             obscureText = !obscureText;
//           });
//         },
//         child: obscureText
//             ? const Icon(Icons.visibility, color: Palate.black, size: 22)
//             : const Icon(Icons.visibility_off, color: Palate.black, size: 22));
//   }

//   TextInputType keyboardType() {
//     return isEmail
//         ? TextInputType.emailAddress
//         : isPassword
//             ? TextInputType.visiblePassword
//             : TextInputType.text;
//   }

//   bool get isEmail => widget.type == Type.email;

//   bool get isPassword => widget.type == Type.password;
//   bool get isConfirm => widget.type == Type.confirm;
// }

// enum Type { email, password, general, confirm }

// enum For { signin, signup }

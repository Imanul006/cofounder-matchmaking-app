import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/screens/login/components/login_form.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kiuqi/providers/login_provider.dart';
import 'package:kiuqi/utils/loading_animation.dart';
import 'package:provider/provider.dart';

bool isLoading = false;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height) / 2.5,
            child: Image.asset(
              ImageLinks.LOGIN_HEADER,
              fit: BoxFit.fill,
            ),
          ),
           Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.componentSideMargin,
              ),
              child: context.watch<LoginProvider>().isLoading ? LoadingAnimation.spin(): const LoginForm(),
            ),
          )
        ],
      ),
    );
  }
}

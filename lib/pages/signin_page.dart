import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{appName}}/components/forms/app_form.dart';
import 'package:{{appName}}/components/label_wrapper.dart';
import 'package:{{appName}}/pages/routes.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final passwordObscured = useState(true);
    final confirmPasswordObscured = useState(true);

    return AppForm(
      formBuilderKey: formKey,
      onSubmit: (formFields) {
        context.go(Routes.home.name);
      },
      formBuilder: (submit, reset) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 0,
          title: Text('Tell us about yourself'),
          leading: SizedBox.shrink(),
          surfaceTintColor: Colors.white,
          actions: [IconButton(onPressed: context.pop, icon: Icon(Icons.close))],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
          children: [
            SizedBox(height: 20),
            LabelWrapper(
              label: Text('Username'),
              child: FormBuilderTextField(
                name: 'username',
                maxLines: 1,
              ),
            ),
            LabelWrapper(
              label: Text('Password'),
              child: FormBuilderTextField(
                name: 'password',
                maxLines: 1,
                obscureText: passwordObscured.value,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    child: Icon(passwordObscured.value ? Icons.remove_red_eye_outlined : Icons.password),
                    onTap: () {
                      passwordObscured.value = !passwordObscured.value;
                    },
                  ),
                ),
              ),
            ),
            LabelWrapper(
              label: Text('Confirm Password'),
              child: FormBuilderTextField(
                name: 'confirmPassword',
                obscureText: confirmPasswordObscured.value,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    child: Icon(confirmPasswordObscured.value ? Icons.remove_red_eye_outlined : Icons.password),
                    onTap: () {
                      passwordObscured.value = !passwordObscured.value;
                    },
                  ),
                ),
                validator: (input) {
                  if (input == null) return null;
                  if (input == formKey.currentState?.fields['password']?.value) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(child: Text('Next'), onPressed: submit),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

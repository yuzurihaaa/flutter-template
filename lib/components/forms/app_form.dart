import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef OnSubmitForm = Function(Map<String, dynamic> formProps);

typedef AppFormBuilder = Function(VoidCallback? submit, VoidCallback reset);

/// Lazy wrapper for Form builder.
///
/// Idea from React form.
///
/// ```jsx
/// <form onSubmit={this.mySubmitHandler}>
///   <h1>Hello!</h1>
///   <p>Enter your name, and submit:</p>
///   <input
///     type='text'
///     onChange={this.myChangeHandler}
///   />
///   <input
///     type='submit'
///   />
/// </form>
/// ```
///
/// ```dart
/// AppForm(
///   onSubmit: mySubmitHandler,
///   formBuilder: (submit, reset) => Column(
///     children: [
///      Text('Hello!'),
///      Text('Enter your name, and submit:'),
///      InputForm(onChange:myChangeHandler),
///      Button(onPress: submit)
///     ]
///   )
/// )
/// ```
class AppForm extends StatefulWidget {
  final GlobalKey<FormBuilderState>? formBuilderKey;
  final AppFormBuilder? formBuilder;
  final OnSubmitForm? onSubmit;
  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic> initialValue;
  final bool readOnly;
  final WillPopCallback? onWillPop;
  final bool shouldValidateOnInit;
  final bool showError;
  final Function(Map<String, dynamic>)? onChanged;

  const AppForm({
    super.key,
    this.formBuilderKey,
    this.formBuilder,
    this.onSubmit,
    this.autovalidateMode,
    this.initialValue = const {},
    this.readOnly = false,
    this.onWillPop,
    this.onChanged,
    this.shouldValidateOnInit = false,
    this.showError = true,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  GlobalKey<FormBuilderState>? _fbKey;

  bool _validInput = false;

  bool get shouldValidateOnInit => widget.shouldValidateOnInit;

  bool get showError => widget.showError;

  AutovalidateMode? get autovalidateMode => widget.autovalidateMode;

  static AppFormState? of(BuildContext context) => context.findAncestorStateOfType<AppFormState>();

  @override
  void initState() {
    super.initState();
    _fbKey = widget.formBuilderKey ?? GlobalKey<FormBuilderState>();
    if (widget.shouldValidateOnInit) {
      Future.delayed(Duration.zero, _updateValidate);
    }
    if (widget.autovalidateMode == AutovalidateMode.disabled) {
      _validInput = true;
    }
  }

  void _reset() {
    _fbKey!.currentState!.reset();
  }

  void _onSubmit() {
    if (_fbKey!.currentState!.saveAndValidate()) {
      widget.onSubmit!(_fbKey!.currentState!.value);
    }
  }

  void _validateOnChange() {
    _updateValidate();
    final currentValue =
        Map<String, dynamic>.unmodifiable(_fbKey!.currentState!.fields.map((key, value) => MapEntry(key, value.value)));
    widget.onChanged?.call(currentValue);
  }

  void _updateValidate() {
    if (!mounted) return;
    if (widget.autovalidateMode == AutovalidateMode.disabled) {
      _fbKey!.currentState!.save();
      return;
    }

    final valid = _fbKey!.currentState!.saveAndValidate();
    if (valid != _validInput) {
      setState(() {
        _validInput = valid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      onChanged: _validateOnChange,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.initialValue,
      enabled: !widget.readOnly,
      onWillPop: widget.onWillPop,
      child: widget.formBuilder!(_validInput ? _onSubmit : null, _reset),
    );
  }
}

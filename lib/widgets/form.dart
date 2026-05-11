import 'package:absensi_hash/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppForm extends StatefulWidget {
  final String? title;
  final bool isRequired;
  final TextEditingController? controller;
  final Widget? prefixIcon, suffixIcon;
  final bool isError, isPassword;
  final String? hintText, forceErrorText;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final bool showCounterText;
  final void Function()? onTap;
  final int? maxLength;

  const AppForm({
    super.key,
    this.title,
    this.isRequired = false,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isError = false,
    this.isPassword = false,
    this.hintText,
    this.forceErrorText,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.isReadOnly = false,
    this.showCounterText = false,
    this.onTap,
    this.maxLength,
  });

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> _isHide;

  @override
  void initState() {
    super.initState();
    _isHide = ValueNotifier(true);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _isHide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 6.0,
      children: [
        if (widget.title != null)...[
          RichText(
            text: TextSpan(
              text: widget.title,
              style: AppTextStyles.body.copyWith(
                fontWeight: AppTextStyles.semiBold,
              ),
              children: [
                if (widget.isRequired)...[
                  TextSpan(
                    text: "*",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.red,
                      fontWeight: AppTextStyles.semiBold,
                    ),
                  )
                ]
              ]
            )
          ),
        ],
        ValueListenableBuilder(
          valueListenable: _isHide,
          builder: (_, isHide, _) {
            return TextFormField(
              focusNode: _focusNode,
              style: AppTextStyles.body,
              controller: widget.controller,
              obscureText: widget.isPassword ? isHide : false,
              forceErrorText: widget.forceErrorText,
              onChanged: widget.onChanged,
              keyboardType: widget.isPassword ? TextInputType.visiblePassword : widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              readOnly: widget.isReadOnly,
              onTap: widget.onTap,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                counterText: widget.showCounterText ? null : "",
                suffixIcon: () {
                  if (widget.isPassword) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _isHide.value = !_isHide.value,
                      child: Icon(isHide ? Icons.visibility_off : Icons.visibility, color: AppColors.black),
                    );
                  }
                  return widget.suffixIcon;
                } (),
                hintStyle: AppTextStyles.body.copyWith(color: AppColors.gray400),
                enabledBorder: _border(borderColor: AppColors.gray400),
                focusedBorder: _border(borderColor: AppColors.black),
                errorBorder: _border(borderColor: AppColors.red),
                focusedErrorBorder: _border(borderColor: AppColors.red)
              ),
            );
          }
        ),
            
      ],
    );
  }

  InputBorder _border({required final Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: borderColor,
      )
    );
  }
}
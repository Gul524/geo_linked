import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Text field type variants
enum AppTextFieldType { text, email, password, phone, number, multiline }

/// Custom Text Field Widget - Reusable text input with consistent styling
/// Usage: AppTextField.email(controller: emailController, hintText: 'Email')
///        AppTextField.password(controller: passController, hintText: 'Password')
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final AppTextFieldType type;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;

  const AppTextField._({
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    required this.type,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.onSuffixTap,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  /// Standard text field
  factory AppTextField.text({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int? maxLength,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? prefix,
    Widget? suffix,
    VoidCallback? onSuffixTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.text,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLength: maxLength,
      maxLines: 1,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefix: prefix,
      suffix: suffix,
      onSuffixTap: onSuffixTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Email text field
  factory AppTextField.email({
    TextEditingController? controller,
    String? hintText = 'Enter your email',
    String? labelText = 'Email',
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.email,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: 1,
      prefixIcon: Icons.email_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Password text field
  factory AppTextField.password({
    TextEditingController? controller,
    String? hintText = 'Enter your password',
    String? labelText = 'Password',
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.password,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: 1,
      prefixIcon: Icons.lock_outline,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Phone number text field
  factory AppTextField.phone({
    TextEditingController? controller,
    String? hintText = 'Enter your phone number',
    String? labelText = 'Phone',
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.phone,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: 1,
      prefixIcon: Icons.phone_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Number text field
  factory AppTextField.number({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int? maxLength,
    IconData? prefixIcon,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.number,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLength: maxLength,
      maxLines: 1,
      prefixIcon: prefixIcon,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Multiline text field
  factory AppTextField.multiline({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? errorText,
    String? helperText,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int? maxLength,
    int maxLines = 5,
    int minLines = 3,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      type: AppTextFieldType.multiline,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  TextInputType get _keyboardType {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.password:
        return TextInputType.visiblePassword;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.text:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> get _inputFormatters {
    if (widget.inputFormatters != null) return widget.inputFormatters!;

    switch (widget.type) {
      case AppTextFieldType.phone:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppTextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.borderRadius ?? 12);
    final fillColor = widget.fillColor ?? AppColors.surface;
    final borderColor = widget.borderColor ?? AppColors.border;

    return TextFormField(
      controller: widget.controller,
      keyboardType: _keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.type == AppTextFieldType.password
          ? _obscureText
          : false,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      inputFormatters: _inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      validator: widget.validator,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        helperText: widget.helperText,
        filled: true,
        fillColor: widget.enabled
            ? fillColor
            : AppColors.border.withOpacity(0.3),
        prefixIcon:
            widget.prefix ??
            (widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.textSecondary)
                : null),
        suffixIcon: _buildSuffixIcon(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.type == AppTextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    if (widget.suffix != null) return widget.suffix;

    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon, color: AppColors.textSecondary),
        onPressed: widget.onSuffixTap,
      );
    }

    return null;
  }
}

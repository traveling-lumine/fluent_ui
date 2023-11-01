import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';

import 'rounded_rectangle_gradient_border.dart';

/// A colored button.
///
/// {@macro fluent_ui.buttons.base}
///
/// See also:
///
///   * [Button], the default button
///   * [OutlinedButton], an outlined button
///   * [HyperlinkButton], a borderless button with mainly text-based content
class FilledButton extends Button {
  /// Creates a filled button
  const FilledButton({
    super.key,
    required super.child,
    required super.onPressed,
    super.onLongPress,
    super.onTapDown,
    super.onTapUp,
    super.focusNode,
    super.autofocus = false,
    super.style,
    super.focusable = true,
  });

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final buttonTheme = ButtonTheme.of(context);
    return buttonTheme.filledButtonStyle;
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    final def = ButtonStyle(
      backgroundColor: ButtonState.resolveWith((states) {
        return backgroundColor(theme, states);
      }),
      foregroundColor: ButtonState.resolveWith(
        (states) => foregroundColor(theme, states),
      ),
      shape: ButtonState.resolveWith((states) {
        return states.isPressing || states.isDisabled
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.resources.controlFillColorTransparent,
                ),
                borderRadius: BorderRadius.circular(4.0),
              )
            : RoundedRectangleGradientBorder(
                gradient: LinearGradient(
                  begin: const Alignment(0.0, -2),
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.resources.controlStrokeColorOnAccentSecondary,
                    theme.resources.controlStrokeColorOnAccentDefault,
                  ],
                  stops: const [0.33, 1.0],
                  transform: const GradientRotation(pi),
                ),
                borderRadius: BorderRadius.circular(4.0),
              );
      }),
    );

    return super.defaultStyleOf(context).merge(def) ?? def;
  }

  static Color backgroundColor(
    FluentThemeData theme,
    Set<ButtonStates> states,
  ) {
    if (states.isDisabled) {
      return theme.resources.accentFillColorDisabled;
    } else if (states.isPressing) {
      return theme.accentColor.tertiaryBrushFor(theme.brightness);
    } else if (states.isHovering) {
      return theme.accentColor.secondaryBrushFor(theme.brightness);
    } else {
      return theme.accentColor.defaultBrushFor(theme.brightness);
    }
  }

  static Color foregroundColor(
      FluentThemeData theme, Set<ButtonStates> states) {
    final res = theme.resources;
    if (states.isPressing) {
      return res.textOnAccentFillColorSecondary;
    } else if (states.isHovering) {
      return res.textOnAccentFillColorPrimary;
    } else if (states.isDisabled) {
      return res.textOnAccentFillColorDisabled;
    }
    return res.textOnAccentFillColorPrimary;
  }
}

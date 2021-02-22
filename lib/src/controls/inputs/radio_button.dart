import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key key,
    @required this.selected,
    @required this.onChanged,
    this.style,
  }) : super(key: key);

  final bool selected;
  final ValueChanged<bool> onChanged;

  final RadioButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final style = context.theme.radioButtonStyle.copyWith(this.style);
    return HoverButton(
      onPressed: onChanged == null ? null : () => onChanged(!selected),
      builder: (context, state) {
        return AnimatedContainer(
          duration: style.animationDuration ?? Duration(milliseconds: 300),
          height: 20,
          width: 20,
          decoration: selected
              ? style?.checkedDecoration(state)
              : style?.uncheckedDecoration(state),
        );
      },
    );
  }
}

class RadioButtonStyle {
  final ButtonState<Decoration> checkedDecoration;
  final ButtonState<Decoration> uncheckedDecoration;

  final ButtonState<MouseCursor> cursor;

  final Duration animationDuration;
  final Curve animationCurve;

  const RadioButtonStyle({
    this.cursor,
    this.animationDuration,
    this.animationCurve,
    this.checkedDecoration,
    this.uncheckedDecoration,
  });

  static RadioButtonStyle defaultTheme(Style style, [Brightness brightness]) {
    final accent = style.accentColor;
    final def = RadioButtonStyle(
      cursor: (state) => state.isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.linear,
      checkedDecoration: (state) => BoxDecoration(
        border: Border.all(
          color: inputColor(accent, state),
          width: 4.5,
        ),
        shape: BoxShape.circle,
      ),
      uncheckedDecoration: (state) => BoxDecoration(
        border: Border.all(
          width: 1.3,
          color:
              state.isDisabled ? kDefaultButtonDisabledColor : Colors.grey[220],
        ),
        shape: BoxShape.circle,
      ),
    );
    if (brightness == null || brightness == Brightness.light)
      return def.copyWith(RadioButtonStyle());
    else
      return def.copyWith(RadioButtonStyle());
  }

  RadioButtonStyle copyWith(RadioButtonStyle style) {
    if (style == null) return this;
    return RadioButtonStyle(
      cursor: style?.cursor ?? cursor,
      animationCurve: style?.animationCurve ?? animationCurve,
      animationDuration: style?.animationDuration ?? animationDuration,
      checkedDecoration: style?.checkedDecoration ?? checkedDecoration,
      uncheckedDecoration: style?.uncheckedDecoration ?? uncheckedDecoration,
    );
  }
}

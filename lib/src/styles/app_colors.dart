import 'dart:ui';

class AppColors {
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color gray4;
  final Color gray5;
  final Color gray6;
  final Color gray7;
  final Color gray8;
  final Color white;
  final Color black;
  final Color red;
  final Color blue;

  Color get background => gray1;
  Color get primary => gray3;
  Color get secondary => gray2;
  Color get disabledBackgroundColor => gray2;
  Color get disabledForegroundColor => gray3;

  AppColors({
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.gray5,
    required this.gray6,
    required this.gray7,
    required this.gray8,
    required this.white,
    required this.black,
    required this.red,
    required this.blue,
  });

  factory AppColors.light() {
    return AppColors(
      gray1: Color(0xFFFCFCFC),
      gray2: Color(0xFFF7F7F7),
      gray3: Color(0xFFE5E6E8),
      gray4: Color(0xFFB1B4B9),
      gray5: Color(0xFF9BA1AA),
      gray6: Color(0xFF737679),
      gray7: Color(0xFF4E5760),
      gray8: Color(0xFF121418),
      white: Color(0xFFFCFCFC),
      black: Color(0xFF121418),
      red: Color(0xFFF94D43),
      blue: Color(0xFF0094FF),
    );
  }

  factory AppColors.dark() {
    return AppColors(
      gray1: Color(0xFF12171E),
      gray2: Color(0xFF383D43),
      gray3: Color(0xFF626364),
      gray4: Color(0xFF7F8287),
      gray5: Color(0xFFA2A4A7),
      gray6: Color(0xFFD3D3D3),
      gray7: Color(0xFFE4E6EA),
      gray8: Color(0xFFFAFAFA),
      white: Color(0xFFFAFAFA),
      black: Color(0xFF12171E),
      red: Color(0xFFEF4B41),
      blue: Color(0xFF048AEB),
    );
  }
}

extension ColorTransparencyX on Color {
  Color get opacity60 => withOpacity(0.6);
  Color get opacity20 => withOpacity(0.2);
}

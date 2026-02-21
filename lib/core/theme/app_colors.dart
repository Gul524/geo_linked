import 'package:flutter/material.dart';

/// App color palette - centralized color definitions
/// Based on GeoLinked design system
class AppColors {
  AppColors._();

  // ============ PRIMARY COLORS ============
  /// Cobalt Blue - Main brand color
  static const Color primary = Color(0xFF0047AB);

  /// Sky Blue - Accent/light primary
  static const Color primaryLight = Color(0xFF00BFFF);
  static const Color primaryDark = Color(0xFF003380);
  static const Color primaryContainer = Color(0xFFE8EEFF);

  // ============ SECONDARY COLORS ============
  static const Color secondary = Color(0xFF636366);
  static const Color secondaryLight = Color(0xFFAEAEB2);
  static const Color secondaryDark = Color(0xFF48484A);

  // ============ ACCENT/STATUS COLORS ============
  static const Color accent = Color(0xFF00BFFF);
  static const Color accentLight = Color(0xFF5DD3FF);
  static const Color accentDark = Color(0xFF0080CC);

  // Status Colors
  static const Color success = Color(0xFF34C759);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFFF9500);
  static const Color warningLight = Color(0xFFFFF4E6);
  static const Color error = Color(0xFFFF3B30);
  static const Color errorLight = Color(0xFFFFE5E5);
  static const Color info = Color(0xFF0047AB);
  static const Color infoLight = Color(0xFFE8F1FF);

  // ============ BACKGROUND COLORS - LIGHT THEME ============
  static const Color background = Color(0xFFF2F2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF2F2F7);

  // ============ BACKGROUND COLORS - DARK THEME ============
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceSecondaryDark = Color(0xFF2C2C2E);

  // ============ TEXT COLORS - LIGHT THEME ============
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF636366);
  static const Color textTertiary = Color(0xFFAEAEB2);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color textLight = Color(0xFFFFFFFF);

  // ============ TEXT COLORS - DARK THEME ============
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFAEAEB2);
  static const Color textTertiaryDark = Color(0xFF636366);

  // ============ BORDER COLORS ============
  static const Color border = Color(0xFFE5E5EA);
  static const Color borderDark = Color(0xFF38383A);
  static const Color glassBorder = Color(0x59FFFFFF); // 35% white

  // ============ SHADOW COLORS ============
  static const Color shadow = Color(0x21004AAB); // 13% cobalt mix
  static const Color shadowDark = Color(0x40000000);

  // ============ GLASS/BLUR EFFECTS ============
  static const Color glass = Color(0x2EFFFFFF); // 18% white
  static const Color glassDark = Color(0x14000000); // 8% black

  // ============ MAP SPECIFIC COLORS ============
  static const Color mapBackground = Color(0xFFCFD9E8);
  static const Color mapGrid = Color(0x1F648CC8);
  static const Color mapRoad = Color(0xFFFFFFFF);

  // ============ MARKER COLORS ============
  static const Color markerTraffic = Color(0xFFFF9500);
  static const Color markerSafety = Color(0xFFFF3B30);
  static const Color markerMarket = Color(0xFF0047AB);
  static const Color markerUtility = Color(0xFF34C759);

  // ============ GRADIENTS ============
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F4FF), Color(0xFFE8EEFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient onboardingGradient = LinearGradient(
    colors: [Color(0xFFEEF4FF), Color(0xFFF9FBFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient authHeroGradient = LinearGradient(
    colors: [primary, Color(0xFF0080E0), primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient mapGradient = LinearGradient(
    colors: [
      Color(0xFFCFD9E8),
      Color(0xFFDCE6F2),
      Color(0xFFE8EFF8),
      Color(0xFFC8D8E8),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.3, 0.6, 1.0],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [primary, Color(0xFF0060D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ DARK THEME GRADIENTS ============
  static const LinearGradient splashGradientDark = LinearGradient(
    colors: [Color(0xFF1C1C1E), Color(0xFF0D1B2A), Color(0xFF1B2838)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient mapGradientDark = LinearGradient(
    colors: [
      Color(0xFF1A2332),
      Color(0xFF1E2836),
      Color(0xFF222C3A),
      Color(0xFF1A2332),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.3, 0.6, 1.0],
  );
}

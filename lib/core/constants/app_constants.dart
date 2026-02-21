/// App-wide constants based on GeoLinked design system
class AppConstants {
  AppConstants._();

  // ============ APP INFO ============
  static const String appName = 'GeoLinked';
  static const String appTagline = 'Your world, connected in real-time';
  static const String appVersion = '1.0.0';

  // ============ API ============
  static const int apiTimeoutSeconds = 30;

  // ============ PADDING & SPACING ============
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // ============ BORDER RADIUS (from HTML design) ============
  static const double radiusXS = 4.0;
  static const double radiusSM = 12.0; // --radius-sm
  static const double radiusMD = 18.0; // --radius-md
  static const double radiusLG = 28.0; // --radius-lg
  static const double radiusXL = 32.0; // For sheets
  static const double radiusRound = 100.0;
  static const double radiusMarker = 14.0;
  static const double radiusPill = 20.0;

  // ============ ICON SIZES ============
  static const double iconXS = 14.0;
  static const double iconSM = 18.0;
  static const double iconMD = 22.0;
  static const double iconLG = 32.0;
  static const double iconXL = 44.0;
  static const double iconXXL = 52.0;

  // ============ LOGO SIZES ============
  static const double logoSmall = 48.0;
  static const double logoMedium = 72.0;
  static const double logoLarge = 96.0;

  // ============ ANIMATION DURATIONS ============
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration pulseDuration = Duration(milliseconds: 2400);

  // ============ MAP CONSTANTS ============
  static const double defaultAskRadius = 300.0; // meters
  static const double defaultBroadcastRadius = 10000.0; // meters (10km)
  static const double minRadius = 100.0;
  static const double maxAskRadius = 1000.0;
  static const double maxBroadcastRadius = 50000.0; // 50km
  static const int mapGridSize = 32;

  // ============ BOTTOM SHEET ============
  static const double sheetHandleWidth = 40.0;
  static const double sheetHandleHeight = 4.0;
  static const double sheetBorderRadius = 32.0;

  // ============ NAV BAR ============
  static const double navBarHeight = 96.0;
  static const double statusBarHeight = 54.0;

  // ============ MARKER SIZES ============
  static const double markerSize = 44.0;
  static const double markerSizeSmall = 36.0;

  // ============ FAB SIZES ============
  static const double fabSize = 60.0;
  static const double fabBorderRadius = 20.0;

  // ============ AVATAR SIZES ============
  static const double avatarSmall = 36.0;
  static const double avatarMedium = 72.0;
  static const double avatarLarge = 96.0;

  // ============ INPUT HEIGHTS ============
  static const double inputHeight = 48.0;
  static const double textAreaHeight = 88.0;
  static const double buttonHeight = 52.0;
}

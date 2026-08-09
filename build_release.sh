#!/bin/bash
# =============================================================================
# SinoSpark Production Build Script
# =============================================================================
# Usage:
#   ./build_release.sh ios       → builds iOS release .ipa
#   ./build_release.sh android   → builds Android release .aab
#   ./build_release.sh all       → builds both
#
# Prerequisites:
#   - Flutter SDK installed
#   - For iOS: run on macOS with Xcode installed
#   - For Android: Java/Android SDK installed
#   - .env file present in project root (for local builds only)
# =============================================================================

set -e  # Exit immediately on any error

# ─── Colours ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Colour

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   SinoSpark — Production Build${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ─── Validate argument ─────────────────────────────────────────────────────────
TARGET=${1:-"all"}
if [[ "$TARGET" != "ios" && "$TARGET" != "android" && "$TARGET" != "all" ]]; then
  echo -e "${RED}Error: Invalid target '$TARGET'. Use: ios | android | all${NC}"
  exit 1
fi

# ─── Clean & get dependencies ─────────────────────────────────────────────────
echo -e "\n${YELLOW}▶ Cleaning build cache...${NC}"
flutter clean

echo -e "\n${YELLOW}▶ Getting dependencies...${NC}"
flutter pub get

# ─── Run analysis ─────────────────────────────────────────────────────────────
echo -e "\n${YELLOW}▶ Running flutter analyze...${NC}"
flutter analyze --no-fatal-infos
echo -e "${GREEN}✓ Analysis passed${NC}"

# ─── Load API keys from .env ──────────────────────────────────────────────────
# For release builds, keys are injected at compile time via --dart-define.
# The .env file is NOT bundled in the app binary — it is only read here,
# on your local machine or CI server, at build time.
if [ ! -f ".env" ]; then
  echo -e "${RED}Error: .env file not found in project root.${NC}"
  echo -e "       Create it with your API keys before building."
  exit 1
fi

echo -e "\n${YELLOW}▶ Loading API keys from .env...${NC}"

# Parse each key from .env (ignores empty lines and comments)
load_key() {
  grep -E "^$1=" .env | cut -d '=' -f2- | tr -d '\r'
}

GEMINI_API_KEY=$(load_key GEMINI_API_KEY)
OPENROUTER_API_KEY=$(load_key OPENROUTER_API_KEY)
AZURE_SPEECH_KEY=$(load_key AZURE_SPEECH_KEY)
AZURE_SPEECH_REGION=$(load_key AZURE_SPEECH_REGION)
YOUTUBE_API_KEY=$(load_key YOUTUBE_API_KEY)
YOUTUBE_API_KEY_2=$(load_key YOUTUBE_API_KEY_2)
YOUTUBE_API_KEY_3=$(load_key YOUTUBE_API_KEY_3)
REVENUECAT_APPLE_API_KEY=$(load_key REVENUECAT_APPLE_API_KEY)
REVENUECAT_GOOGLE_API_KEY=$(load_key REVENUECAT_GOOGLE_API_KEY)

echo -e "${GREEN}✓ API keys loaded${NC}"

# ─── Build flags ──────────────────────────────────────────────────────────────
OBFUSCATE_FLAGS="--obfuscate --split-debug-info=build/debug-info"

DEFINE_FLAGS="\
  --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY \
  --dart-define=OPENROUTER_API_KEY=$OPENROUTER_API_KEY \
  --dart-define=AZURE_SPEECH_KEY=$AZURE_SPEECH_KEY \
  --dart-define=AZURE_SPEECH_REGION=$AZURE_SPEECH_REGION \
  --dart-define=YOUTUBE_API_KEY=$YOUTUBE_API_KEY \
  --dart-define=YOUTUBE_API_KEY_2=$YOUTUBE_API_KEY_2 \
  --dart-define=YOUTUBE_API_KEY_3=$YOUTUBE_API_KEY_3 \
  --dart-define=REVENUECAT_APPLE_API_KEY=$REVENUECAT_APPLE_API_KEY \
  --dart-define=REVENUECAT_GOOGLE_API_KEY=$REVENUECAT_GOOGLE_API_KEY"


# ─── iOS Build ────────────────────────────────────────────────────────────────
build_ios() {
  echo -e "\n${YELLOW}▶ Building iOS release (.ipa)...${NC}"
  flutter build ipa \
    --release \
    $OBFUSCATE_FLAGS \
    $DEFINE_FLAGS \
    --export-method app-store

  echo -e "${GREEN}✓ iOS build complete${NC}"
  echo -e "   → build/ios/ipa/*.ipa"
  echo -e "\n${YELLOW}⚠  Upload debug symbols to Firebase Crashlytics:${NC}"
  echo -e "   → build/debug-info/ → upload via fastlane or Firebase CLI"
}

# ─── Android Build ────────────────────────────────────────────────────────────
build_android() {
  echo -e "\n${YELLOW}▶ Building Android release (.aab)...${NC}"
  flutter build appbundle \
    --release \
    $OBFUSCATE_FLAGS \
    $DEFINE_FLAGS

  echo -e "${GREEN}✓ Android build complete${NC}"
  echo -e "   → build/app/outputs/bundle/release/app-release.aab"
  echo -e "\n${YELLOW}⚠  Upload debug symbols to Google Play Console:${NC}"
  echo -e "   → build/debug-info/ → upload as 'native debug symbols' in Play Console"
}

# ─── Execute ──────────────────────────────────────────────────────────────────
if [[ "$TARGET" == "ios" || "$TARGET" == "all" ]]; then
  build_ios
fi

if [[ "$TARGET" == "android" || "$TARGET" == "all" ]]; then
  build_android
fi

echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   Build complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "${YELLOW}Before submitting to stores, remember:${NC}"
echo -e "  1. Remove .env from pubspec.yaml assets"
echo -e "  2. Rotate all API keys"
echo -e "  3. Upload debug symbols from build/debug-info/"
echo -e "  4. Test the release build on a real device"

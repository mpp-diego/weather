# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

#Build target
-android

# For SBB
-keep,includecode class SecureBlackbox.Base.** { *; }
-keep,includecode class ** extends org.freepascal.** { *; }

# For Sentry
-keep class io.sentry.event.Event { *; }

# Google Vision - used for sandbox
-keep,includecode class com.google.android.gms.**  { *; }

# Obfuscates kotlin metadata
# Flag is named `keepkotlinmetadata` but actually this causes the metadata to be obfuscated
# Without the flag metadata is left as is
-keepkotlinmetadata

# To help with debugging
-printconfiguration "build/outputs/dexguard/mapping/configuration.txt"

-obfuscatecode,high class com.mypinpad.**

-encryptstrings class !com.mypinpad.common.crypto.cmac.WbcAesCbcNoPaddingInstance,**
-multidex

# After benchmarking the app, virtualizing x25519 showed a significant performance slowdown so we chose to exclude it from virtualization
# Issues observed with networking exception flow across the app when using DG 8.5 so virt use has been vastly reduced
# TODO: disabled due to crashes on protected builds: https://mypinpad.atlassian.net/browse/OMP-227
-virtualizecode class com.mypinpad.goodfellow.transaction.internal.secure.**

-keepresourcexmlattributenames **

# Only for the inDevice build, but needs to be place here as it should be included before the default DexGuard configuration
# There is a bug in DexGuard which causes some natives libraries to be stripped from needed ELF sections during the obfuscation,
# this is the case for the 32 bits native library contained in the TA-intertrust library
# TODO remove this rule once this bugs is fixed https://mypinpad.atlassian.net/browse/OA-522
-adaptresourcefilecontents !lib/armeabi-v7a/libitse.so

#InDevice driven changes
# temporary workaround to VerifyError on startup on some devices
-dontoptimize

-keepresourcefiles res/raw/emv_config.json
-keepresourcefiles res/raw/emv_config_no_pin.json

# Keep JNI methods
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}
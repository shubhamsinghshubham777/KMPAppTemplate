#!/bin/sh

# Prompt the user for input
echo "
🔥Welcome to KMP App Template Wizard 🔥
"
echo "Enter your choice:"
echo "1 -> Update namespace and applicationId for Android"
echo "2 -> Update bundleId for iOS"
echo "3 -> Update namespace for Android in shared module"
echo "4 -> Exit"
read -r choice

# If the user chooses to replace the applicationId
if [ "$choice" = "1" ]; then
  # Prompt the user for input with a default value
  echo "Enter old applicationId (default is 'app.kmp.android'): \c"
  read -r oldApplicationId

  # Use the default value if the user input is blank
  if [ -z "$oldApplicationId" ]; then
    oldApplicationId="app.kmp.android"
  fi

  # Prompt for the new applicationId
  echo "Enter applicationId (hint: com.example.identifier): \c"
  read -r applicationId

  # Check if the file exists
  if [ -f android/build.gradle.kts ]; then
    # Use sed to replace the applicationId within the file
    sed -i '' "s/$oldApplicationId/$applicationId/g" android/build.gradle.kts

    # Notify the user of successful replacement
    echo "
    ✅ ApplicationId successfully updated in android/build.gradle.kts!
    Please 'Sync Project with Gradle Files' before running the project.
    "
  else
    # Notify the user if the file is not found
    echo "❌ Error: android/build.gradle.kts file not found."
  fi

# If the user chooses to replace the bundleId
elif [ "$choice" = "2" ]; then
  # Prompt the user for input with a default value
  echo "Enter old bundleId (default is 'app.kmp.ios'): \c"
  read -r oldBundleId

  # Use the default value if the user input is blank
  if [ -z "$oldBundleId" ]; then
    oldBundleId="app.kmp.ios"
  fi

  # Prompt for the new bundleId
  echo "Enter bundleId (hint: com.example.ios): \c"
  read -r bundleId

  if [ -f ios/ios.xcodeproj/project.pbxproj ]; then
    sed -i '' "s/$oldBundleId/$bundleId/g" ios/ios.xcodeproj/project.pbxproj
    echo "✅ BundleId successfully replaced in ios/ios.xcodeproj/project.pbxproj!"
  else
    echo "❌ Error: ios/ios.xcodeproj/project.pbxproj file not found."
  fi

elif [ "$choice" = "3" ]; then
  echo "Enter old namespace (default is 'app.kmp'): \c"
  read -r oldNamespace

  # Use the default value if the user input is blank
  if [ -z "$oldNamespace" ]; then
    oldNamespace="app.kmp"
  fi

  # Prompt for the new namespace
  echo "Enter namespace (hint: com.example.ios): \c"
  read -r namespace

  if [ -f shared/build.gradle.kts ]; then
    sed -i '' "s/$oldNamespace/$namespace/g" shared/build.gradle.kts
    echo "
        ✅ namespace successfully updated in shared/build.gradle.kts!
        Please 'Sync Project with Gradle Files' before running the project.
        "
  else
    echo "❌ Error: shared/build.gradle.kts file not found."
  fi

elif [ "$choice" = "4" ]; then
  echo "Thanks for using our wizard. Have fun with your new project 🥳"
  exit 1

else
  echo "❌ Please enter a valid input!"
fi

# Re-run the script
exec "$0" "$@"

#!/usr/bin/env bash

echo "warning: Detected Prebuild Step"
mkdir -p ~/.mobile-secrets/iOS/WPiOS/
cp ${BUDDYBUILD_SECURE_FILES}/wpcom_app_credentials ~/.mobile-secrets/iOS/WPiOS/wpcom_app_credentials
cp ${BUDDYBUILD_SECURE_FILES}/wpcom_internal_app_credentials ~/.mobile-secrets/iOS/WPiOS/wpcom_internal_app_credentials
cp ${BUDDYBUILD_SECURE_FILES}/wpcom_alpha_app_credentials ~/.mobile-secrets/iOS/WPiOS/wpcom_alpha_app_credentials
cp ${BUDDYBUILD_SECURE_FILES}/wpcom_test_credentials ~/.wpcom_test_credentials
echo "warning: Copied files over"

echo "Installing plugin"
cd cocoapods-repo-update/
gem build cocoapods-repo-update.gemspec
gem install cocoapods-repo-update-0.0.1.gem

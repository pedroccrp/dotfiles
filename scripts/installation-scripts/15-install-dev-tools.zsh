sudo chown -R $USER:$USER /opt/android-sdk

sdkmanager --install "build-tools;36.0.0"
sdkmanager --install "platforms;android-36"
sdkmanager --install "sources;android-36"

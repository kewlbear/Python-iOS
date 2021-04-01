cd kivy-ios

xcodebuild -create-xcframework -output libpython3.xcframework \
	-library dist/frameworks/python3.xcframework/ios-arm64/libpython3.8.a -headers dist/root/python3/include/python3.8 \
	-library dist/frameworks/python3.xcframework/ios-x86_64-simulator/libpython3.8.a -headers dist/root/python3/include/python3.8

xcodebuild -create-xcframework -output Frameworks/python3.xcframework \
	-library ci/dist/frameworks/python3.xcframework/ios-arm64/libpython3.8.a -headers ci/dist/root/python3/include/python3.8 \
	-library ci/dist/frameworks/python3.xcframework/ios-x86_64-simulator/libpython3.8.a -headers ci/dist/root/python3/include/python3.8

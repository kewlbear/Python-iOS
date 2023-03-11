git clone --depth 1 https://github.com/kewlbear/kivy-ios.git
cd kivy-ios

python3 -m venv venv
. venv/bin/activate

pip install -e .
pip install cython==0.29.33

python toolchain.py build python3

for f in dist/frameworks/*.xcframework
do
	otool -l $f/ios-arm64/lib*.a | grep __LLVM >/dev/null
	if [ $? ]
	then
		echo "$(basename $f) contains bitcode"
	else
		echo "$(basename $f) does NOT contain bitcode"
	fi
done

mv dist/frameworks/lib* .
mv libpython3.xcframework dist/frameworks

rm -rf ../Sources/PythonSupport/lib
mv dist/root/python3/lib ../Sources/PythonSupport

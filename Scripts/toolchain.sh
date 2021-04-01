git clone --depth 1 https://github.com/kewlbear/kivy-ios.git
cd kivy-ios

python3 -m venv venv
. venv/bin/activate

pip install -e .
pip install cython

python toolchain.py build python3

mv dist/frameworks/lib* .

rm -rf ../Sources/PythonSupport/lib
mv dist/root/python3/lib ../Sources/PythonSupport

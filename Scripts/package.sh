TAG=$1

cd kivy-ios

sed s/TAG/$TAG/g ../Package.swift.in > Package.swift

rm *.zip

for f in *.xcframework
do
	zip -r $f.zip $f
	rm Package.swift.in
	mv Package.swift Package.swift.in
	sed s/"$f"_CHECKSUM/`swift package compute-checksum $f.zip`/ Package.swift.in > Package.swift
done

rm ../Package.swift
mv Package.swift ..

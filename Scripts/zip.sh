cd Frameworks
rm *.zip

for f in *.xcframework
do
	zip -r $f.zip $f
	swift package compute-checksum $f.zip
done

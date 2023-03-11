sh Scripts/toolchain.sh

sh Scripts/build.sh

TAG=v0.1.0-`date +%Y.%m.%d-%H.%M.%S`

sh Scripts/package.sh $TAG

echo "::set-output name=tag::$TAG"

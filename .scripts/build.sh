
VERSION=$(if [ $# -ge 1 ]; then echo "$1"; else echo ""; fi)
SUFFIX=$(if [ "$VERSION" = "" ]; then echo ""; else echo "-$VERSION"; fi)

mkdir -p output

typst compile --root . tsconvn.typ output/tsconvn$SUFFIX.pdf --no-pdf-tags

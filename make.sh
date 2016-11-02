 #!/bin/bash
 if [ -f settings.sh ];
then
    source "settings.sh"
fi

SWIFT_BIN=`which swift`
OPENSSL_BIN=`which openssl`

if [ "$OPENSSL_BIN" == "" ];
then
    sudo apt-get install  -y  openssl
    OPENSSL_BIN=`which openssl`
fi

if [ "$SWIFT_BIN" == "" ];
then
    sudo apt-get install -y python python-pip python-dev
    sudo pip install python-swiftclient python-keystoneclient
    SWIFT_BIN=`which swift`
fi

rm -Rf $OUT_DIR
mkdir -p $OUT_DIR
cp data/* $OUT_DIR/

rm -Rf $TMP_DIR
mkdir -p $TMP_DIR

IFS=',' 
for f in $MODS; 
do 
    file="index/$f.sh"
    echo "Run $file"
    chmod +x $file
    $file $OUT_DIR $TMP_DIR
done

cd $OUT_DIR
$SWIFT_BIN -V 2.0 upload $TARGET_CONTAINER *   --skip-identical
echo "Done!"
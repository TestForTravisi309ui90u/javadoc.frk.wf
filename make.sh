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

for file in index/*.sh
do
    echo "Run $file"
    chmod +x $file
    $file $OUT_DIR $TMP_DIR
done

cd $OUT_DIR
while IFS= read -d $'\0' -r file ; do
    echo "Upload $file"
    #$SWIFT_BIN -V 2.0 upload $TARGET_CONTAINER $file   
done < <(find * -type f -print0)
OUT_DIR=$1
TMP_DIR=$2
CURR_DIR=$PWD

GIT_BIN=`which git`


if [ "$GIT_BIN" == "" ];
then
    sudo apt-get install  -y  git
    GIT_BIN=`which git`
fi

if [ ! -d  $TMP_DIR/jme-frk ];
then
    $GIT_BIN clone https://github.com/riccardobl/jmonkeyengine.git  $TMP_DIR/jme-frk
fi

cd $TMP_DIR/jme-frk
mkdir -p $CURR_DIR/$OUT_DIR/jmonkeyengine

$GIT_BIN checkout frk
$GIT_BIN pull origin frk
./gradlew mergedJavadoc
cp -Rf  dist/javadoc  $CURR_DIR/$OUT_DIR/jmonkeyengine/frk
$GIT_BIN reset --hard HEAD
echo "<a href='frk/'>frk</a><br />" >> $CURR_DIR/$OUT_DIR/jmonkeyengine/index.html


OUT_DIR=$1
TMP_DIR=$2
CURR_DIR=$PWD

GIT_BIN=`which git`
ANT_BIN=`which ant`


if [ "$GIT_BIN" == "" ];
then
    sudo apt-get install git
    GIT_BIN=`which git`
fi

if [ "$ANT_BIN" == "" ];
then
    sudo apt-get install  -y  ant
    ANT_BIN=`which ant`
fi

if [ ! -d  $TMP_DIR/jme ];
then
    $GIT_BIN clone https://github.com/jMonkeyEngine/jmonkeyengine.git  $TMP_DIR/jme
fi

cd $TMP_DIR/jme

$GIT_BIN checkout 3.0
$GIT_BIN  pull origin 3.0

$ANT_BIN javadoc
cp -Rf dist/javadoc $CURR_DIR/$OUT_DIR/jme3.0
$GIT_BIN  reset --hard HEAD

$GIT_BIN checkout v3.1
$GIT_BIN  pull origin v3.1
./gradlew mergedJavadoc
cp -Rf  dist/javadoc  $CURR_DIR/$OUT_DIR/jme3.1
$GIT_BIN  reset --hard HEAD

$GIT_BIN checkout master
$GIT_BIN  pull origin master
./gradlew mergedJavadoc
cp -Rf dist/javadoc $CURR_DIR/$OUT_DIR/jme-master
$GIT_BIN  reset --hard HEAD



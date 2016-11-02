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
mkdir -p $CURR_DIR/$OUT_DIR/jmonkeyengine


$GIT_BIN checkout 3.0
$GIT_BIN  pull origin 3.0

cd engine
$ANT_BIN javadoc
cp -Rf dist/javadoc $CURR_DIR/$OUT_DIR/jmonkeyengine/3.0
$GIT_BIN  reset --hard HEAD
echo "<a href='3.0/'>3.0</a><br />" >> $CURR_DIR/$OUT_DIR/jmonkeyengine/index.html

$GIT_BIN checkout v3.1
$GIT_BIN  pull origin v3.1
./gradlew mergedJavadoc
cp -Rf  dist/javadoc  $CURR_DIR/$OUT_DIR/jmonkeyengine/3.1
$GIT_BIN  reset --hard HEAD
echo "<a href='3.1/'>3.1</a><br />" >> $CURR_DIR/$OUT_DIR/jmonkeyengine/index.html


$GIT_BIN checkout PBRisComing
$GIT_BIN  pull origin PBRisComing
./gradlew mergedJavadoc
cp -Rf  dist/javadoc  $CURR_DIR/$OUT_DIR/jmonkeyengine/PBRisComing
$GIT_BIN  reset --hard HEAD
echo "<a href='PBRisComing/'>PBRisComing</a><br />" >> $CURR_DIR/$OUT_DIR/jmonkeyengine/index.html


$GIT_BIN checkout master
$GIT_BIN  pull origin master
./gradlew mergedJavadoc
cp -Rf dist/javadoc $CURR_DIR/$OUT_DIR/jmonkeyengine/master
$GIT_BIN  reset --hard HEAD
echo "<a href='master/'>master</a><br />" >> $CURR_DIR/$OUT_DIR/jmonkeyengine/index.html


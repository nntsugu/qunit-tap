#!/bin/sh

DIR=$(cd $(dirname $0) && pwd)

SUITE_DIR=${DIR}/compatibility
ROOT_DIR=`dirname ${DIR}`

if [ ! -e $DIR/js.jar ]; then
    $DIR/download_rhino.sh
fi

HEAD_VERSION_TEST_DIR=${SUITE_DIR}/head
$DIR/download_qunit_head.sh $HEAD_VERSION_TEST_DIR

NUM=1
for version in $(ls $SUITE_DIR)
do
    java -jar $DIR/js.jar $DIR/rhino/test_compat_rhino.js $version $ROOT_DIR > ${DIR}/actual.txt

    $DIR/compare_with_expected_output.sh $version $NUM

    NUM=`expr $NUM + 1`
done

echo "1..$(echo `ls $SUITE_DIR | wc -l`)"

rm -rf $HEAD_VERSION_TEST_DIR

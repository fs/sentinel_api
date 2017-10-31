PROCESSES_NUM = $1
OPENFACE_PATH = $2
USER_DATA = $3
ALIGNED_DATA = $4
FEATURE_DIR = $USER_DATA/feature

for N in {1..$PROCESSES_NUM};
do $OPENFACE_PATH/util/align-dlib.py $USER_DATA align outerEyesAndNose $ALIGNED_DATA --size 96 &
done

$OPENFACE_PATH/batch-represent/main.lua -outDir $FEATURE_DIR -data $ALIGNED_DATA

$OPENFACE_PATH/demos/classifier.py train $FEATURE_DIR

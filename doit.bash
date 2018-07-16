#! /bin/bash

# ------------------------------------------------------------------------

# exit on error
set -e

if [ "$PVSE" ] ; then
    # In order to help test portability, I eliminate all of my
    # personalizations from the PATH.
    export PATH=/usr/local/bin:/usr/bin:/bin
fi

# ------------------------------------------------------------------------

# fixme: hardcoded
HOWTO="./scripts/howto -f howto.yaml"

# Set the variables that were not set in the config file
function process_single_end {
    # fixme - should error check
    INPUT_FILE="$1" ; shift 1

    # fixme - should check that output files do not exist
    OUTPUT_FILE="results/$(basename $INPUT_FILE)"

    ROOT_DIR=$(./scripts/find-closest-ancester-dir $THIS_DIR $INPUT_FILE)
    PHRED_ARG=-phred33 ; [ "$USE_PHRED64" ] && PHRED_ARG=-phred64

    (
	set -x
	$HOWTO -m $ROOT_DIR -c __trimmomatic__ \
	       java -jar /opt/Trimmomatic/trimmomatic.jar \
	       SE $PHRED_ARG \
	       $INPUT_FILE $OUTPUT_FILE \
	       "$@"
    )
}

function process_paired_end {
    # fixme - should error check
    INPUT1_FILE="$1" ; shift 1
    INPUT2_FILE="$1" ; shift 1

    # fixme - should check that output files do not exist
    OUTPUT1_FILE="results/$(basename $INPUT1_FILE)"
    OUTPUT2_FILE="results/$(basename $INPUT2_FILE)"
    UNPAIRED1_FILE="results/unpaired-$(basename $INPUT1_FILE)"
    UNPAIRED2_FILE="results/unpaired-$(basename $INPUT2_FILE)"

    # fixme - should check that output files do not exist
    
    ROOT_DIR=$(./scripts/find-closest-ancester-dir $THIS_DIR $INPUT1_FILE $INPUT2_FILE)
    PHRED_ARG=-phred33 ; [ "$USE_PHRED64" ] && PHRED_ARG=-phred64

    (
	set -x
	$HOWTO -m $ROOT_DIR -c __trimmomatic__ \
	       java -jar /opt/Trimmomatic/trimmomatic.jar \
	       PE $PHRED_ARG \
	       "$INPUT1_FILE" "$INPUT2_FILE" \
	       "$OUTPUT1_FILE" "$UNPAIRED1_FILE" \
	       "$OUTPUT2_FILE" "$UNPAIRED2_FILE" \
	       "$@"
    )
}

# ------------------------------------------------------------------------

# Process the config file

THIS_DIR=$(dirname $BASH_SOURCE)
CONFIG_SCRIPT=$THIS_DIR/config.bash
if [ ! -e "$CONFIG_SCRIPT" ] ; then
    echo 1>&2 Cannot find "$CONFIG_SCRIPT"
    exit 1
fi

# ------------------------------------------------------------------------

# The actual computation starts here

(
    set -x
    cd $THIS_DIR
    rm -rf results
    mkdir results
)

. "$CONFIG_SCRIPT"


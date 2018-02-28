#!/bin/bash

project='tweetdeck'

function usage {
    cat<<EOF>&2

Synopsis

  $0 <dirn>

Description

  Named directory requires 'index.txt' which lists collection by name.
  The files listed in 'index.txt' must not have a directory path
  prefix.

EOF
    exit 1
}

#
# (main)
#
if [ -n "${1}" ]&&[ -d "${1}" ]
then
    src=$(basename "${1}")
    idx="${src}/index.txt"
    tgt="${project}-${src}.gif"

    if [ -f "${idx}" ]&& flist=$(egrep -v '^#' "${idx}" ) &&[ -n "${flist}" ]
    then
	

	if conf_delay=$(egrep '^#.*delay' ${idx} | sed 's/.*delay[: =]//; s/ //g;') &&
	    [ -n "${conf_delay}" ]&&[ 0 -lt "${conf_delay}" ]
	then
	    animation="convert -delay ${conf_delay} -loop 0 ${flist} ${tgt}"
	else
	    animation="convert -delay 800 -loop 0 ${flist} ${tgt}"
	fi

	animation=$(echo "${animation}" | tr '\n' ' ' )

	if cd ${src} && ${animation}
	then
	    #
	    git add ${tgt}

	    eog ${tgt} &

	    exit 0
	else
	    cat<<EOF>&2
$0 error running '${animation}' in directory '${src}'.
EOF
	    exit 1
	fi
	
    else
	cat<<EOF>&2
$0 error: file not found '${idx}', or found empty.
EOF
	exit 1
    fi
else
    usage
fi

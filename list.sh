#!/bin/bash
#
# 
#
dir_src=~/Pictures
dat_src=$(date +%Y-%m-%d)
dat_tgt=$(date +%Y%m%d)
#
# 
#
function last {

    if dir=$(2>/dev/null ls -d ${dat_tgt}-* | sort -V | tail -n 1)&& [ -n "${dir}" ]&&[ -d "${dir}" ]
    then
        echo "${dir}"
        return 0
    else
        return 1
    fi
}
#
# 
#
function list {

    if [ -n "${1}" ]&&[ -d "${1}" ]
    then
        dir_tgt="${1}"

        for srcf in $(2>/dev/null ls ${dir_src}/Screenshot\ from\ ${dat_src}* | sed 's/ /%%%/g;')
        do 
            srcf=$(echo $srcf | sed 's/%%%/ /g')
            echo "${srcf}"
        done

        return 0
    else
        return 1
    fi
}
#
# 
#
if dir_tgt=$(last)
then

    if list ${dir_tgt}
    then
        exit 0
    else
        exit 1
    fi

else
    cat<<EOF>&2
$0 error, missing directory '${dat_tgt}-1'.
EOF
    exit 1
fi

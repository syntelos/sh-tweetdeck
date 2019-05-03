#!/bin/bash

dir_src=~/Pictures
dat_src=$(date +%Y-%m-%d)
dat_tgt=$(date +%Y%m%d)

dir_tgt=${dat_tgt}-1
index_tgt=${dir_tgt}/index.txt

if [ ! -f ${index_tgt} ]
then
    cat<<EOF>${index_tgt}
# delay 300
# resize 60%
EOF
fi

for srcf in $(2>/dev/null ls ${dir_src}/Screenshot\ from\ ${dat_src}* | sed 's/ /%%%/g;')
do 
    srcf=$(echo $srcf | sed 's/%%%/ /g')

    tgtf=${dir_tgt}/tweetdeck-$(echo $srcf | sed 's%.*Screenshot from %%; s%-%%g; s% %-%g;')

    echo mv "${srcf}" "${tgtf}"

    if mv "${srcf}" "${tgtf}"
    then
        git add "${tgtf}"

        echo "${tgt}" >> ${index_tgt}
    fi
done

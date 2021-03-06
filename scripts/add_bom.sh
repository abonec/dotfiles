#!/bin/sh

if [ $# -eq 0 ];
then
        echo usage $0 files ...
        exit 1
fi

for file in $*;
do
        echo "# Processing: $file" 1>&2
        if [ ! -f "$file" ];
        then
                echo Not a file: "$file" 1>&2
                exit 1
        fi
        TYPE=`file - < "$file" | cut -d: -f2`
        if echo "$TYPE" | grep -q '(with BOM)';
        then
                echo "# $file already has BOM, skipping." 1>&2
        else
		pwd=`pwd`
		basename=`basename ${file}`
		backup="${pwd}/${basename}~"
                ( mv ${file} ${backup} && uconv -f utf-8 -t utf-8 --add-signature < "${backup}" > "${file}" ) || ( echo Error processing "$file" 1>&2 ; exit 1)
        fi
done

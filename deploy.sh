#!/bin/bash

fs+=(.emacs.d)

date=`date +"%s"`
# move same filename to end up with _data.bak for backup old file.
git submodule init
git submodule update
for f in ${fs[*]}
do
	if [[ ! -L ${HOME}/${f} ]]; then
		if [[ -f ${HOME}/${f} ]] || [[ -d ${HOME}/${f} ]]; then
			echo "backup ${HOME}/${f} => ${HOME}/${f}_${date}_bak"
			mv ${HOME}/${f} ${HOME}/${f}_${date}_bak;
		fi
	else
		echo "delete symbolic link ${HOME}/${f}"
		rm ${HOME}/${f}
	fi
		echo "link ${PWD}/${f} => ${HOME}/${f}"
		ln -s ${PWD}/${f} ${HOME}/${f}
done


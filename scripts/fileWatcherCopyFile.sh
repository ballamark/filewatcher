#
#   [bash] fileWatcherCopyFile.sh file module rootDirectoryForServer [logger]
#
#       file:                   forrásfile elérési útja az aktuális könyvtárhoz viszonyítva
#       module:                 web modul neve, ahová a fájlt be kell mésolni
#       projectRoot:           project root elérése
#       rootDirectoryForServer: gyökérkönyvtár, ahol lehet keresni a deployolt war állományt
#       logger:                 ha meg van adva, debug üzenet kiírása
#

# Unix-kompatibilis fájl elérési út
fileUnixpath=${1//\\//}

# Másolandó fájl relatív elérési útja
dirprefix=`echo $fileUnixpath | sed "s:$2/src/main/webapp/::" | sed "s:[^/]*\.xhtml$::"`;

projectUnixPath=${3//\\//}
deploymentUnixPath=${4//\\//}
# Telepített web modulhoz tartozó, szerveren belüli ideiglenes munkakönyvtár elérési útja
targetdir=`find $deploymentUnixPath -type d -name "*$2.war-*"`;

# Másolás, ha megtaláltunk a deployolt modul könyvtárat
if [ "$targetdir" ]; then
    cp $projectUnixPath/$fileUnixpath $targetdir/$dirprefix
fi

# Debug üzenet, ha meg van adva logger
if [ "$5" ]; then
    echo
    echo "[$5]:" $1 '==>' $targetdir/$dirprefix
fi
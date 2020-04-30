#
#   [bash] fileWatcherCopyFile.sh file module rootDirectoryForServer [logger]
#
#       file:                   forrásfile elérési útja az aktuális könyvtárhoz viszonyítva
#       module:                 web modul neve, ahová a fájlt be kell mésolni
#       projectRoot:            project root elérése
#       rootDirectoryForServer: gyökérkönyvtár, ahol lehet keresni a deployolt war állományt
#       onlyWar:                ha meg van adva, akkor csak war modult keres
#

# Unix-kompatibilis fájl elérési út
fileUnixpath=${1//\\//}

# Másolandó fájl relatív elérési útja
dirprefix="";
if [ "$5" ]; then
  dirprefix=`echo $fileUnixpath | sed "s:$2/src/main/webapp/::" | sed "s:[^/]*\.xhtml$::" | cut -c17-`;
# cut -c17- levágja a "src/main/webapp/" részt
else
  dirprefix=`echo $fileUnixpath | sed "s:$2/src/main/webapp/::" | sed "s:[^/]*\.xhtml$::"`;
fi

projectUnixPath=${3//\\//}
deploymentUnixPath=${4//\\//}
# Telepített web modulhoz tartozó, szerveren belüli ideiglenes munkakönyvtár elérési útja
if [ "$5" ]; then
  targetName="*content-*";
else
  targetName="*$2.war-*";
fi

targetdir=`find $deploymentUnixPath -type d -name $targetName`;

# Másolás, ha megtaláltunk a deployolt modul könyvtárat
if [ "$targetdir" ]; then
    cp $projectUnixPath/$fileUnixpath $targetdir/$dirprefix
fi

echo
echo "[LOGGER]:" $projectUnixPath/$fileUnixpath '==>' $targetdir/$dirprefix
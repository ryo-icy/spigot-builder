#!/bin/bash
if [ $# != 1 ]; then
    echo +-------------------------------------+
    echo Usage:
    echo "${0} <spigot version>"
    echo +-------------------------------------+
    exit 1
fi

check_error () {
    if [ $1 != 0 ]; then
        echo $2
        exit 1
    fi
}

mkdir spigot_build_tmp
check_error $? "Permisson error"

cd ./spigot_build_tmp
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
check_error $? "Failed to download BuildTools.jar"

java -jar BuildTools.jar --rev ${1}
check_error $? "Spigot build failed."

mv ./spigot-${1}.jar ../
cd ..
rm -rf spigot_build_tmp/

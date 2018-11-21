#!/bin/sh

COLOR='\033[0;36m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
NC='\033[0m' # No Color


projectDir=~/domains/;
if [[ ! -z $@ ]]; then
        projectDir=$@;
fi;

if [ ! -d "$projectDir" ]; then
        printf "${COLOR_RED}$projectDir - doesn't exist\n${NC}"
        exit;
fi;

if [ -d .git ]; then
        found='git'
else
        found=$(git rev-parse --git-dir 2> /dev/null)
fi;

if [[ ! -z "$found" ]]; then
        $(git fetch 2> /dev/null) && $(git describe --tags $(git rev-list --tags --max-count=1 > /dev/null) > /dev/null)
        lastTag=$(git gt)
        printf "Последний тэг в релизе: ${COLOR_GREEN}$lastTag\n${NC}"
fi;

dirNow=$(pwd)

gitDirs=`find $projectDir -maxdepth 2 -name .git`
for repo in ${gitDirs[@]}
do
        pathName="${repo}/HEAD"
        branchName=$(expr "$(cat $pathName)" : 'ref:\srefs/heads/\(.*\)')
        dir=$( echo $pathName | cut -d "/" -f5)

        isChange=""
        if [[ -z $(cd "${repo}/../" && git status | grep 'nothing to commit') ]]; then
                isChange=" / ${COLOR_RED}edit${COLOR}"
        fi;

        tag=$(cd "${repo}/../" && git log | grep "tag: refs/tags/v*"|head -1)
        tag=${tag//*tags\//};
        tag=${tag//,*/};
        tag=${tag//)/};
        tag=" / ${COLOR_YELLOW}$tag${COLOR}"


        printf "$dir ${COLOR}($branchName$isChange$tag)\n${NC}"
done

cd $dirNow

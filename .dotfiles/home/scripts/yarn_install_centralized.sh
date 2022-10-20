ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh

NODE_MODULES_DIR=~/node_mods
PROJECT_DIR=$PWD
PROJECT_MODULES_DIR=$NODE_MODULES_DIR$PWD

if [ ! -d  "$PROJECT_MODULES_DIR" ]; then mkdir -p "$PROJECT_MODULES_DIR"; fi;

if [ -f  "$PWD/package.json" ]; then 
    ln -sf $PWD/package.json $PROJECT_MODULES_DIR/package.json
fi;

if [ -f  "$PWD/package-lock.json" ] 
then 
    ln -sf $PWD/package-lock.json $PROJECT_MODULES_DIR/package-lock.json
    cd $PROJECT_MODULES_DIR && yarn i $@ && cd -
else
    cd $PROJECT_MODULES_DIR && yarn i $@ && cd -
    ln -sf $PROJECT_MODULES_DIR/package-lock.json $PWD/package-lock.json
fi;

ln -sf $PROJECT_MODULES_DIR/node_modules $PWD/node_modules

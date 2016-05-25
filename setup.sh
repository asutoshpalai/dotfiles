#!/usr/bin/env bash
shopt -s extglob
ln -s $(dirname "$0")/*/!(..|.) ~/

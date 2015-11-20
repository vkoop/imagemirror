#!/bin/bash

BASEDIR=$(dirname $0)
source "$BASEDIR/config.sh"

nohup bash -C "$BASEDIR/create_listener.sh" > /dev/null 2>&1 &
echo "started create listener"

nohup bash -C "$BASEDIR/delete_listener.sh" > /dev/null 2>&1 &
echo "started delete listener"

nohup bash -C "$BASEDIR/move_listener.sh" > /dev/null 2>&1 &
echo "started move listener"

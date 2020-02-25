#!/usr/bin/env bash
curl -sL "https://piccolo.link/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local
ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt
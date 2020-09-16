# voxel-cat ![Optimize](https://github.com/gaborbata/voxel-cat/workflows/Optimize/badge.svg)

## Overview

[voxel-cat](http://gaborbata.github.io/voxel-cat/) is an entry for the
[JS1k 2019 "X"](https://js1k.com/2019-x/) JavaScript code golfing competition.

The goal of the competition is to create a fancy JavaScript demo up to 1024 bytes.

![voxel-cat](https://raw.githubusercontent.com/gaborbata/voxel-cat/master/voxel-cat.png)

## Demo Description

This entry is a demonstration of CT scan, also known as computed tomography scan,
and formerly known as CAT scan, which makes use of computer-processed combinations
of many X-ray measurements taken from different angles to produce cross-sectional
images of a scanned object, allowing the user to see inside the object without cutting.

## Data

Demo data is based on [Wioletta Orłowska](http://orlowska.tumblr.com/)'s
[voxel cat image](http://orlowska.tumblr.com/post/163178813780/im-sooo-excited-working-on-a-new-game-with)
with small modifications.

Voxel data has been created with
[Goxel](https://github.com/guillaumechereau/goxel) voxel editor.

## Optimizations

Voxel data has been compressed with a fixed-length pattern substitution
compression algorithm implemented in [Ruby](https://github.com/ruby/ruby)
with a small decompressor in JavaScript.

Among various code golfing tricks, for further optimizations the JavaScript code
has been minified with [Closure Compiler](https://github.com/google/closure-compiler)
with minor manual tweaks baked into a [Gradle](https://github.com/gradle/gradle) script.

#!/bin/bash
# Cocoapod update
echo "Cocoapods updating"

rm -rf Iwoo.xcworkspace

pod install --verbose


echo "Cocoapods updated"

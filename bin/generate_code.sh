#!/bin/sh

echo "Generating code from annotations (injectable, retrofit, json_serializer)"

cd rousseau_vote
flutter pub run build_runner build --delete-conflicting-outputs
cd ..

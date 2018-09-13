#!/bin/bash
FROM="eoscityioeos"
TO="eoscityioeos"
NET="99.0000 EOS"
CPU="99.0000 EOS"


./cleos.sh system delegatebw $FROM $TO "$NET" "$CPU" -p $FROM

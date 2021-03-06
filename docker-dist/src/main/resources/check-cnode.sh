#!/usr/bin/env bash
#
# Copyright 2016-2017 Red Hat, Inc. and/or its affiliates
# and other contributors as indicated by the @author tags.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if [ -z ${1} ]; then
   echo "Missing Cassandra node address"
   exit 1
fi

while : ; do
   timeout 5 nc -w 2 $1 9160 > /dev/null 2>&1
   status=$?
   if [[ $status -eq 2 ]]; then
     echo "Invalid host"
     exit 2
   fi

   if [[ $status -eq 124 || $status -eq 0 ]]; then
     echo "DB service online"
     exit 0
   fi
done

exit 124

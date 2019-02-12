#!/bin/bash
#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -xeo pipefail
shopt -s nullglob

for test in /tests/*; do
  testspec="$(mktemp XXXXXXXX.yaml)"
  # TODO(marketplace-testrunner/issues/5): Add --substitutions param to testrunner
  envsubst '${APP_INSTANCE_NAME} ${NAMESPACE} ${MYSQL_ROOT_PASSWORD} ${WORDPRESS_DB_USER} ${WORDPRESS_DB_PASSWORD} ${WORDPRESS_DB_NAME}' < "${test}" > "${testspec}"
  cat "${testspec}"
  testrunner -logtostderr "--test_spec=${testspec}"
done

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


data "google_organization" "org" {
  domain = var.domain
}

locals {
  customer_id = data.google_organization.org.directory_customer_id
  type        = "default"
  label_keys = {
    "default"  = "cloudidentity.googleapis.com/groups.discussion_forum"
    "dynamic"  = "cloudidentity.googleapis.com/groups.dynamic"
    "security" = "cloudidentity.googleapis.com/groups.security"
    "external" = "system/groups/external"
  }
}

resource "google_cloud_identity_group" "group" {
  provider     = google-beta
  for_each     = toset(var.groups)
  display_name = "Group to force conflict account for terminated employee ${each.value}@${var.domain}"
  description  = "Group to force conflict account for terminated employee ${each.value}@${var.domain}"

  parent = "customers/${local.customer_id}"

  group_key {
    id = "${each.value}@${var.domain}"
  }

  labels = {
    local.label_keys[local.type] = ""
  }
}

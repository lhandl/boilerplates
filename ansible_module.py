#!/usr/bin/env python3

from ansible.module_utils.basic import AnsibleModule
import requests
import json


def main():
  module_args = {
    # example argument
    'name': {'type': 'str', 'required': True}
  }
  module = AnsibleModule(argument_spec=module_args, supports_check_mode=False)

  # params to local variables
  name = module.params['name']

  try:
    # do something

    result = {
      'changed': True
      # add additional results
    }
    module.exit_json(**result)

  except requests.exceptions.RequestException as e:
    module.fail_json(msg="Module failed: {}".format(str(e)))
  module.exit_json(**result)

if __name__ == '__main__':
    main()

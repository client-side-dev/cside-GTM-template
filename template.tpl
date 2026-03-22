___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "cside",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "brand_cside",
    "displayName": "cside",
    "thumbnail": "CsideBue96x96.png"
  },
  "description": "cside monitors third-party scripts running on your website and detects malicious behavior in real time. This tag injects the cside monitoring script.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "containerId",
    "displayName": "Container ID",
    "simpleValueType": true,
    "notSetText": "Enter your cside Container ID",
    "help": "Your cside Container ID can be found in the cside dashboard under Settings.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const setInWindow = require('setInWindow');

const containerId = data.containerId;
const scriptUrl = 'https://proxy.csidetm.com/script.js';

// set the container id so the cside script can identify this installation
setInWindow('__cside_container_id', containerId, true);

injectScript(scriptUrl, data.gtmOnSuccess, data.gtmOnFailure, 'cside');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://proxy.csidetm.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__cside_container_id"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Injects cside script successfully
  code: |-
    const mockData = {
      containerId: 'test-container-123',
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', (url, onSuccess, onFailure, cacheToken) => {
      assertThat(url).isEqualTo('https://proxy.csidetm.com/script.js');
      assertThat(cacheToken).isEqualTo('cside');
      onSuccess();
    });

    mock('setInWindow', (key, value, overwrite) => {
      assertThat(key).isEqualTo('__cside_container_id');
      assertThat(value).isEqualTo('test-container-123');
      assertThat(overwrite).isTrue();
    });

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: Calls gtmOnFailure when script fails to load
  code: |-
    const mockData = {
      containerId: 'test-container-123',
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', (url, onSuccess, onFailure, cacheToken) => {
      onFailure();
    });

    mock('setInWindow', () => {});

    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();


___NOTES___

cside - Client-side threat detection and web security.
https://cside.com

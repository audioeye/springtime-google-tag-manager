___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "categories": ["AFFILIATE_MARKETING", "ADVERTISING"],
  "version": 1,
  "securityGroups": [],
  "displayName": "Springtime Consent Management Template",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "This template allows Springtime to integrate with Google Consent Mode",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "CHECKBOX",
    "name": "ads_data_redaction",
    "checkboxText": "Redact ads data",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "url_passthrough",
    "checkboxText": "Pass through URL parameters",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// The first two lines are optional, use if you want to enable logging
const log = require('logToConsole');
log('data =', data);
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const localStorage = require('localStorage');
const setInWindow = require('setInWindow');
const gtagSet = require('gtagSet');
const JSON = require('JSON');

const CONSENT_DECISION_KEY = 'ae_gcm_user_consent_decision';
const ALLOW_COOKIES_ON_LOAD_KEY = 'ae_gcm_should_allow_cookies_on_load';

/*
 *   Called when consent changes. Assumes that consent object contains keys which
 *   directly correspond to Google consent types.
 */
const onUserConsentDecisionMade = (consent) => {
  log('updating consent decision =', consent);
  updateConsentState(consent);
};

const getConsentObjectAllCookiesAllowed = () => {
  return {
    ad_storage: 'granted',
    ad_user_data: 'granted',
    ad_personalization: 'granted',
    analytics_storage: 'granted',
    functionality_storage: 'granted',
    personalization_storage: 'granted',
    security_storage: 'granted',
  };
};

const getConsentObjectNecessaryCookiesOnly = () => {
  return {
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied',
    functionality_storage: 'granted',
    personalization_storage: 'denied',
    security_storage: 'granted',
  };
};

/*
 *   Executes the default command, sets the developer ID, and sets up the consent
 *   update callback
 */
const main = (data) => {
  /*
   * Optional settings using gtagSet
   */
  gtagSet('ads_data_redaction', data.ads_data_redaction);
  gtagSet('url_passthrough', data.url_passthrough);
  gtagSet('developer_id.dZmNhMz', true);
  
  let userConsentDecision = JSON.parse(localStorage.getItem(CONSENT_DECISION_KEY));
  if (userConsentDecision === null) {
    const shouldAllowCookiesOnLoad = JSON.parse(localStorage.getItem(ALLOW_COOKIES_ON_LOAD_KEY));
    userConsentDecision = shouldAllowCookiesOnLoad ? getConsentObjectAllCookiesAllowed() : getConsentObjectNecessaryCookiesOnly();
  }
  userConsentDecision.wait_for_update = 1000;
  setDefaultConsentState(userConsentDecision);
  log('consentDecision =', userConsentDecision);

  /**
   *   Add event listener to trigger update when consent changes
   *
   *   References an external method on the window object which accepts a
   *   function as an argument. If you do not have such a method, you will need
   *   to create one before continuing. This method should add the function
   *   that is passed as an argument as a callback for an event emitted when
   *   the user updates their consent. The callback should be called with an
   *   object containing fields that correspond to the five built-in Google
   *   consent types.
   */
 setInWindow('aeGTMConsentDecisionCallback', onUserConsentDecisionMade);
};
main(data);
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
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
                    "string": "aeGTMConsentDecisionCallback"
                  },
                  {
                    "type": 8,
                    "boolean": true
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
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
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
        "publicId": "access_local_storage",
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ae_gcm_user_consent_decision"
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
              },
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
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ae_gcm_should_allow_cookies_on_load"
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
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
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
- name: initial state/first time viewer/strict banner
  code: "/**\nNote: we cannot add additional tests because this mock function is fundamentally\
    \ broken by Google\nTry uncommenting it, and you will see.\n\nDocs here: https://developers.google.com/tag-platform/tag-manager/templates/api#mock\n\
    \nmock('localStorage', {\n  getItem: (key) => {\n    if (key === 'ae_gcm_should_allow_cookies_on_load')\
    \ {\n      return 'false'; \n    }\n\n    return null;\n  },\n});\n\n**/\n\nconst\
    \ mockData = {\n  ads_data_redaction: false,\n  url_passthrough: false,\n};\n\n\
    // Call runCode to run the template's code.\nrunCode(mockData);\n\n// Verify that\
    \ the tag finished successfully.\nassertApi('setDefaultConsentState').wasCalledWith({\n\
    \  ad_storage: 'denied',\n  ad_user_data: 'denied',\n  ad_personalization: 'denied',\n\
    \  analytics_storage: 'denied',\n  functionality_storage: 'granted',\n  personalization_storage:\
    \ 'denied',\n  security_storage: 'granted',\n  wait_for_update: 500,\n});\n\n\
    assertApi('updateConsentState').wasNotCalled();\n"


___NOTES___

Created on 5/21/2024, 12:09:39 PM



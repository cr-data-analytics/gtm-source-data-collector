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
  "displayName": "Source Data to Local Storage",
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFAAAABQCAMAAAC5zwKfAAAAA3NCSVQICAjb4U/gAAAAX3pUWHRSYXcgcHJvZmlsZSB0eXBlIEFQUDEAAAiZ40pPzUstykxWKCjKT8vMSeVSAANjEy4TSxNLo0QDAwMLAwgwNDAwNgSSRkC2OVQo0QAFmJibpQGhuVmymSmIzwUAT7oVaBst2IwAAABRUExUReQLPuUaSucpVuk4YutIbuxWeexXeu5mhvB1kvB2kvGEnvKFn/OTqvOUq/WjtvWkt/eywvezw/jBzvnCz/rR2vrS2/zg5vzh5/7v8/7w8////5Dpmn0AAAEUSURBVBgZ7cHBcoMgFAXQixCJtcYI1cj9/w9tpqCmCW6emS46nIOiKIqiKB5UZ+fIyV1OeAfjuPlQOEg5/jJbHKInPrvgAD3z1RViamZOBynPPAOZmqvgvedqgsyNSbC4Ux0XFhKayagQWSYDJDomGouWiYKAZ9RjpZgYCNwY1dh4Rg0EmBhsekYtBJgYbAZGLQQ8I4vNyMhCwDNyWFVMDAQaJjUWnlGARMVkrvFDXZj0EPFcuJOCPk9cGIho7vAQ6pgVKkh55tQQUyNfWRygej4JNY6xNz7qKxxmRyah13gLVbd3jcb/pz6/+GK+akiNzNOQsdwxQKbljhkyLXd4yFSBeQ2ETGBOCzmToVAURVEUf+EbyiBDB0tRcqwAAAAASUVORK5CYII\u003d"
  },
  "description": "Get source data from url parameter (e.g. utm_source, utm_medium) to be saved in the local storage",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "All url parameters will be saved into the local storage once triggering this tag"
  },
  {
    "type": "LABEL",
    "name": "label2",
    "displayName": "Referral data will automatically be added to the object"
  },
  {
    "type": "LABEL",
    "name": "label3",
    "displayName": "Use local storage variable from the custom template to save the values into a variable"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const localStorage = require('localStorage');
const getUrl = require('getUrl');
const JSON = require('JSON');
const getRef = require('getReferrerUrl');

const ref_hostname = getRef('host');
const url_hostname = getUrl('host');

const queryString = getUrl('query');
const current_local_storage_value = localStorage.getItem('source_data');

if (ref_hostname === url_hostname) {
  log("Internal traffic");
} else if (!ref_hostname && current_local_storage_value && !queryString){
  log("Direct traffic with no parameters and previous visit");
} else if (!ref_hostname && !current_local_storage_value && !queryString) {
  log("Direct traffic without previous visit");
  localStorage.setItem('source_data', '{"referral"="Direct"}');
} else {
  log("Non-direct traffic or direct with parameters");

const ref = getRef();
  
const queryPairs = queryString.split('&');
const queries = [];
const source_data = [];

for (let i = 0; i < queryPairs.length; i++) {
    const pair = queryPairs[i].split('=');
    queries.push(pair[0]);
    queries.push(pair[1]);
}
if(ref){
  queries.push("referral", ref);
} else {
  queries.push("referral", "Direct");
}
  
queries.forEach((element) => source_data.push(element));

const obj = {};

for (var i = 0; i < source_data.length; i += 2) {
    obj[source_data[i]] = source_data[i + 1];
}

const str_obj = JSON.stringify(obj);


localStorage.setItem('source_data', str_obj);
}

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
            "string": "all"
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
                    "string": "source_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
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
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
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
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
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

scenarios: []


___NOTES___

Created on 4/5/2024, 1:37:45 PM



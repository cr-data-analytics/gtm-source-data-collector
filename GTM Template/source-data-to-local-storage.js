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
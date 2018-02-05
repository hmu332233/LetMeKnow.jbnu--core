tester = function () {
  
  this.testcases = [
    '참빛',
    '새빛',
    '후생관',
    '진수당',
    '정담원',
    '학생회관',
    '특성화',
    '의대'
  ];
};


tester.prototype.testAll = function (testcases, callback) {
  var self = this;  
  
  var requests = testcases.map(function(testcase) {
    return self.requestMessage(testcase);
  });
  
  requests.forEach(function (request) {
    request.done(function (response) {
      callback(response.message.text);
    });
  });
};

/*
* message: {string} 입력할 메세지 이름  
* successCallback {function}: 성공시 수행할 동작
*/
tester.prototype.requestMessage = function (message, successCallback) {
    
  var settings = {
    "async": true,
    "crossDomain": true,
    "url": "/message",
    "method": "POST",
    "headers": {
      "Content-Type": "application/json"
    },
    "processData": false,
    "data": "{\"content\": \""+ message +"\"}"
  }
  
  return $.ajax(settings);
};
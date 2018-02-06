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


/*
*  테스트케이스들을 받아 결과값을 callback으로 돌려준다.
*  NOTE: 비동기이기때문에 순서를 보장하지는 않으나
*  map으로 promise를 분리했는데 이것이 순서를 보장하는데 도움이 주는지는 잘 모르겠다.
*
*  testcases {Array[String]}: 테스트케이스들의 목록
*  callback {function}: 결과값을 불러왔을때마다 호출될 함수
*/
tester.prototype.testAll = function (testcases, callback) {
  var self = this;  
  
  var requests = testcases.map(function(testcase) {
    return {
      sendMessage: testcase,
      response: self.requestMessage(testcase)
    }
  });
  
  requests.forEach(function (request) {
    request.response.done(function (data, textStatus, xhr) {
      callback({
        sendMessage: request.sendMessage,
        status: xhr.status,
        textStatus: textStatus,
        message: data.message.text,
      });
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
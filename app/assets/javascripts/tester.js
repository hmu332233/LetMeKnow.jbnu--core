tester = function () {
  
  this.testcases = {
    food: [
      '참빛',
      '새빛',
      '후생관',
      '진수당',
      '정담원',
      '학생회관',
      '특성화',
      '의대'
    ],
    notice: [
      '교내공지',
      '교내채용',
      '특강',
      '스터디',
      '알바',
      '판매구매',
      '자취',
      '분실물'
    ],
    etc: [
      '치킨집',
      '날씨',
      '내일 날씨',
      '주간 날씨',
      '알려줘 과사 소',
      '알려줘 치킨몇마리 8명',
      '편의점',
      '버스 위치',
      '버스 시간',
      '중도 자리',
      '중도 시간',
      '중도'
    ]
  }
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
        message: data.template.outputs[0].simpleText.text,
      });
    });
  });
};

/*
* message: {string} 입력할 메세지 이름  
* successCallback {function}: 성공시 수행할 동작
*/
tester.prototype.requestMessage = function (message, successCallback) {
  
  var data = {
    userRequest: {
      user: { id: 'api_user' },
      utterance: message
    }
  };
  
  var settings = {
    "async": true,
    "crossDomain": true,
    "url": "/message",
    "method": "POST",
    "headers": {
      "Content-Type": "application/json"
    },
    "processData": false,
    "data": JSON.stringify(data)
  }
  
  return $.ajax(settings);
};
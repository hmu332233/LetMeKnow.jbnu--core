tester = function () {
    
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
  
  $.ajax(settings).done(function (response) {
    console.log(response.message.text);
  });
    
};
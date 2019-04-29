## nginx 셋팅

무중단을 위해 nginx를 reverse proxy로 사용한다.


### 사용방법

`/etc/nginx/sites-enabled/default`에 다음과 같이 추가한다  
이후 port2로 앱을 연 뒤 밑의 주석을 서로 바꾸고  
service nginx reload로 재시작하면 중단 없이 앱을 바꿀 수 있다.
```
upstream api {
  server localhost:[PORT];
  #server localhost:[PORT2];
}

server {
  listen 80 default_server;
  listen [::]:80 default_server;

  location / {
    proxy_pass http://api;
  }
}
```
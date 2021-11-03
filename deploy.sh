#!/bin/bash

echo "#################### springbootapp shell start ####################"

echo "================== chmod +x gradlew... =================="
# 실행 권한 허가
chmod +x ./gradlew

echo "================== gradlew clean and build... =================="
./gradlew clean build

#도커 이미지 빌드
echo "================== docker springbootapp image is building =================="
docker build -f Dockerfiles/Dockerfile_Spring -t app-cont ./

# 도커 명령어를 로그 파일에 저장
docker ps -a | grep app-cont > docker_ps_log

echo $(ls -ls | grep docker_ps_log)

# -s : 파일의 크기가 0보다 크면 참
if [ -s docker_ps_log ]
then

	for var in {1..3}
	do
		echo "****************** app-cont"$var" container is running ******************"
		# 스프링부트 컨테이너 10초에 1개씩 제거 후 재실행 - 무중단 배포하기 위해
		docker rm -f app-cont$var
		echo "****************** app-cont"$var" container is removed ******************"

    echo ========================= port 값 : '7'$var'00'
		docker run -itd -p '7'$var'00':8080 --name app-cont$var --net springboot-cicd-test_mysql_net app-cont:latest
		echo "****************** app-cont"$var" container is starting ******************"

		sleep 10
	done
else
	echo "================== springbootapp container is not exist ========================="

	docker run -itd -p 7100:8080 --name app-cont1 --net springboot-cicd-test_mysql_net app-cont:latest
	docker run -itd -p 7200:8080 --name app-cont2 --net springboot-cicd-test_mysql_net app-cont:latest
	docker run -itd -p 7300:8080 --name app-cont3 --net springboot-cicd-test_mysql_net app-cont:latest

fi

# 로그 파일 삭제
rm -f docker_ps_log

echo "#################### springbootapp shell end... ####################"
#!/bin/bash
echo "#################### SpringBootApp Shell script Start!! ####################"

echo "==================== chmod +x gradlew... ===================="
# 실행 권한 허가
chmod +x ./gradlew

echo "==================== gradlew clean and build... ===================="
./gradlew clean build --stacktrace

#도커 이미지 빌드
echo "==================== docker SpringBootApp image is building ===================="
docker build -f Dockerfiles/Dockerfile_Spring -t app-cont ./


# 도커 명령어를 로그 파일에 저장
docker ps -a | grep app-cont > docker_ps_log

echo "*** docker ps _log : "$(ls -ls | grep docker_ps_log)


# -s : 파일의 크기가 0보다 크면 참
if [ -s docker_ps_log ]
then
        for var in {1..3}
        do
           condition=`docker ps -a | grep app-cont${var}`
                if [ -n "${condition}" ]
                then
                        echo "################# app-cont"$var" container is running #################"

                        docker rm -f app-cont$var
                        echo "################# app-cont"$var" container is removed!! #################"

                        docker run -itd -p '7'$var'00':8080 --name app-cont$var --net springboot-cicd-test_mysql_net app-cont:latest
                        echo "################# app-cont"$var" container is restarting!! #################"

                else
                        echo "################# app-cont"$var" container is not running #################"

                        docker run -itd -p '7'$var'00':8080 --name app-cont$var --net springboot-cicd-test_mysql_net app-cont:latest
                        echo "################# app-cont"$var" container is starting!! #################"


                fi

                # 스프링부트 컨테이너 10초에 1개씩 제거 후 재실행 - 무중단 배포하기 위해
                sleep 10
        done
else
        echo "==================== No SpringBootApp containers are running. ===================="
        docker run -itd -p 7100:8080 --name app-cont1 --net springboot-cicd-test_mysql_net app-cont:latest
        docker run -itd -p 7200:8080 --name app-cont2 --net springboot-cicd-test_mysql_net app-cont:latest
        docker run -itd -p 7300:8080 --name app-cont3 --net springboot-cicd-test_mysql_net app-cont:latest

        echo "==================== SpringBootApp containers(app-cont1,2,3) are running. ===================="

fi

# 로그 파일 삭제
rm -f docker_ps_log

echo "#################### springbootapp shell end... ####################"
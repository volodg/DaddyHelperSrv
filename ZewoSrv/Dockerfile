FROM zewo/swiftdocker:0.5.0

ENV APP_NAME=ZewoSrv

WORKDIR /root/DaddyHelperSrv/$APP_NAME/

ADD ./Package.swift /$APP_NAME/
ADD ./Sources /$APP_NAME/Sources

RUN swift build --configuration release

EXPOSE 8080

CMD .build/release/$APP_NAME
FROM zewo/swiftdocker:0.7.0

ENV APP_NAME=ZewoSrv

WORKDIR /$APP_NAME/

ADD ./Package.swift /$APP_NAME/
ADD ./Sources /$APP_NAME/Sources

RUN apt-get update
RUN echo "Y" | apt-get install clang libicu-dev binutils git libpq-dev postgresql

RUN swift build --configuration release

EXPOSE 8080

CMD .build/release/$APP_NAME
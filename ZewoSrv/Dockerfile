FROM ubuntu:15.10

ENV APP_NAME=ZewoSrv

WORKDIR /$APP_NAME/

ADD ./Package.swift /$APP_NAME/
ADD ./Sources /$APP_NAME/Sources

RUN apt-get update
RUN echo "Y" | apt-get install clang libicu-dev binutils git libpq-dev postgresql curl

RUN curl -O https://swift.org/builds/swift-3.0-preview-1/ubuntu1510/swift-3.0-preview-1/swift-3.0-preview-1-ubuntu15.10.tar.gz
RUN tar -zxf swift-3.0-preview-1-ubuntu15.10.tar.gz
RUN mv swift-3.0-preview-1-ubuntu15.10 swift
RUN rm -rf swift-3.0-preview-1-ubuntu15.10.tar.gz

ENV PATH "/$APP_NAME/swift/usr/bin:$PATH"
RUN echo "export PATH=/$APP_NAME/swift/usr/bin:\"\${PATH}\"" >> ~/.bashrc

RUN swift build -Xcc -I/usr/include/postgresql -Xlinker -L/usr/local/lib/
#TODO --configuration release

EXPOSE 8080

CMD .build/debug/$APP_NAME

#CMD while true; do foo; sleep 2; done
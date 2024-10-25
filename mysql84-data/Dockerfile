FROM nfqlt/mysql84:amd64
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_NATIVE_PASSWORD=ON 

ADD build /build
CMD exec ./build/volume-entrypoint.sh

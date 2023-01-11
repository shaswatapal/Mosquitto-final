FROM eclipse-mosquitto as builder
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.16/main/' > /etc/apk/repositories && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.16/community/' >> /etc/apk/repositories && \
    apk add libgcc libc6-compat rust cargo git && \
    git clone https://github.com/shaswatapal/mosquitto-jwt-2021.git && \
    cd mosquitto-jwt-2021 && \
    cargo build --release

FROM eclipse-mosquitto
COPY --from=builder /mosquitto-jwt-2021/target/release/libmosquitto_jwt_auth.so /usr/lib/jwt_auth.so
RUN apk add --no-cache libgcc libc6-compat
	
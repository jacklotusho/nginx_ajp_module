# vi:filetype=perl

use lib 'lib';
use Test::Nginx::LWP;

plan tests => repeat_each() * 2 * blocks();
$ENV{TEST_NGINX_TOMCAT_AJP_PORT} ||= 8009;
no_root_location();

#no_diff;

run_tests();

__DATA__

=== TEST 1: the PUT of AJP
--- http_config
    upstream tomcats{
        server 127.0.0.1:$TEST_NGINX_TOMCAT_AJP_PORT;
        keepalive 10;
    }
--- config
    location / {
        ajp_pass tomcats;
    }
--- request
    PUT /upload.jsp
    username=yaoweibin
--- request_headers
    Content-Type:application/x-www-form-urlencoded
--- response_body_like: ^(.*)$

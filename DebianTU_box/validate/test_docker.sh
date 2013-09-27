# Feature: lxc-docker
# Given docker command
which docker 1>/dev/null 2>&1 || which lxc-docker 1>/dev/null 2>&1
[ $? -ne 0 ] && { printf "\e[1;31mdocker: FAIL\n\e[0m"; exit 1; }
# When I run "docker version" command
sudo docker version 1>/dev/null 2>&1 || sudo lxc-docker version 1>/dev/null 2>&1
[ $? -ne 0 ] && { printf "\e[1;31mdocker version: FAIL\n\e[0m"; exit 1; }
# Then I expect success
printf "\e[1;32mdocker: OK\n\e[0m";

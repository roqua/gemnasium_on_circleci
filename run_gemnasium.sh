#!/bin/sh
if [ -n "${CIRCLE_RUN_GEMNASIUM}" ]; then
    sudo sh -c 'echo "deb http://apt.gemnasium.com stable main" > /etc/apt/sources.list.d/gemnasium.list';
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E5CEAB0AC5F1CA2A;
    sudo apt-get update;
    sudo apt-get install gemnasium-toolbelt;
    [ -z "$GEMNASIUM_TESTSUITE" ] && export GEMNASIUM_TESTSUITE="bundle exec rspec spec";

    echo "#\!/bin/bash\n" > script/gemnasium_tests.sh
    echo $GEMNASIUM_TESTSUITE >> script/gemnasium_tests.sh
    chmod +x script/gemnasium_tests.sh
    export GEMNASIUM_TESTSUITE="script/gemnasium_tests.sh";

    gemnasium --token $GEMNASIUM_TOKEN autoupdate run;
fi

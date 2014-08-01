#!/bin/bash
COMMAND="rsync -r -v -p -z out/ $USER@html.inf.ufrgs.br:/home/www/utug/public_html"
echo -e "I will execute the following command: \n   $COMMAND"
$COMMAND

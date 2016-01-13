#!/bin/bash
cd layersbox
rm -rf *.yml common.env html logs mysql-data openldap-data services ssl tmp
cd ..
echo "cleared box install"
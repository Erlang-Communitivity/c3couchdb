; etc/couchdb/couch.ini.tpl.  Generated from couch.ini.tpl.in by configure.

[Couch]

ConsoleStartupMsg=Apache CouchDB is starting.

DbRootDir=%localstatelibdir%

Port=5984

BindAddress=127.0.0.1

DocumentRoot=%localdatadir%/www

LogFile=%localstatelogdir%/couch.log

UtilDriverDir=%couchprivlibdir%

LogLevel=info

[Couch Query Servers]

javascript=%bindir%/%couchjs_command_name% %localdatadir%/server/main.js

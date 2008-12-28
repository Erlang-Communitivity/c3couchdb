<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<!-- etc/launchd/org.apache.couchdb.plist.tpl.  Generated from org.apache.couchdb.plist.tpl.in by configure. -->
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>org.apache.couchdb</string>
    <key>EnvironmentVariables</key>
    <dict>
      <key>HOME</key>
      <string>~</string>
      <key>DYLD_LIBRARY_PATH</key>
      <string>/opt/local/lib:$DYLD_LIBRARY_PATH</string>
    </dict>
    <key>ProgramArguments</key>
    <array>
      <string>%bindir%/%couchdb_command_name%</string>
    </array>
    <key>UserName</key>
    <string>couchdb</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>OnDemand</key>
    <false/>
  </dict>
</plist>

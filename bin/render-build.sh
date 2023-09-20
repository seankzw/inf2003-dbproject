databases:
  - name: sixguys-healthcompanion
    databaseName: mysite
    user: mysite

services:
  - type: web
    name: mysite
    runtime: ruby
    buildCommand: "./bin/render-build.sh"
    startCommand: "bundle exec puma -C config/puma.rb"
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: mysite
          property: connectionString
      - key: RAILS_MASTER_KEY
        sync: false
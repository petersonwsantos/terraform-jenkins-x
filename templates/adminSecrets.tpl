JXBasicAuth: ${admin_user}:{SHA}${admin_password_jxbasicauth}
chartmuseum:
  secret:
    BASIC_AUTH_USER: ${admin_user}
    BASIC_AUTH_PASS: ${admin_password}
grafana:
  server:
    adminUser: ${admin_user}
    adminPassword: ${admin_password}
jenkins:
  Master:
    adminPassword: ${admin_password}
nexus:
  defaultadminPassword: ${admin_password}
PipelineSecrets:
  MavenSettingsXML: |
    <settings>
          <!-- sets the local maven repository outside of the ~/.m2 folder for easier mounting of secrets and repo -->
          <localRepository>REPLACE1REPLACE2/.mvnrepository</localRepository>
          <!-- lets disable the download progress indicator that fills up logs -->
          <interactiveMode>false</interactiveMode>
          <mirrors>
              <mirror>
              <id>nexus</id>
              <mirrorOf>external:*</mirrorOf>
              <url>http://nexus/repository/maven-group/</url>
              </mirror>
          </mirrors>
          <servers>
              <server>
              <id>local-nexus</id>
              <username>${admin_user}</username>
              <password>${admin_password}</password>
              </server>
          </servers>
          <profiles>
              <profile>
                  <id>nexus</id>
                  <properties>
                      <altDeploymentRepository>local-nexus::default::http://nexus/repository/maven-snapshots/</altDeploymentRepository>
                      <altReleaseDeploymentRepository>local-nexus::default::http://nexus/repository/maven-releases/</altReleaseDeploymentRepository>
                      <altSnapshotDeploymentRepository>local-nexus::default::http://nexus/repository/maven-snapshots/</altSnapshotDeploymentRepository>
                  </properties>
              </profile>
              <profile>
                  <id>release</id>
                  <properties>
                      <gpg.executable>gpg</gpg.executable>
                      <gpg.passphrase>mysecretpassphrase</gpg.passphrase>
                  </properties>
              </profile>
          </profiles>
          <activeProfiles>
              <!--make the profile active all the time -->
              <activeProfile>nexus</activeProfile>
          </activeProfiles>
      </settings>

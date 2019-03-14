node ('ubuntu16.04-basebuild-1c-2g') {
  timeout (100) {
    try {
      stage ('Checkout code') {
        checkout([$class: 'RepoScm', currentBranch: true, manifestRepositoryUrl: 'https://gerrit.opencord.org/manifest', quiet: true])
      }
      stage ('Build and Publish apps') {
        configFileProvider([configFile(fileId: 'onoscord-apps', variable: 'MAVEN_SETTINGS')]) {
          sh 'export _JAVA_OPTIONS=-Djdk.net.URLClassPath.disableClassPathURLCheck=true && cd onos-apps/apps && mvn -s $MAVEN_SETTINGS -e clean deploy'
        }
      }
      currentBuild.result = 'SUCCESS'
    } catch (err) {
      currentBuild.result = 'FAILURE'
      step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: "${notificationEmail}", sendToIndividuals: false])
    }
    echo "RESULT: ${currentBuild.result}"
  }
}

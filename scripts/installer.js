const exec = require('child_process').exec

var osvar = process.platform

if (osvar !== 'darwin') return

exists('pod')
  .then(function(command) {
    installPods()
  })
  .catch(function() {
    installCocoaPods().then(() => {
      installPods()
    })
  })

function installPods() {
  console.log('executing pod install command')

  exec('cd ./ios && pod install', (err, stdout, stderr) => {
    console.log(stderr)

    if (err === undefined || err === null) {
      console.log('pod install command successfull')
      return
    }

    if (stdout !== undefined && stdout !== null) {
      if (stdout.includes('could not find compatible versions for pod')) {
        console.log('executing pod repo update command.')

        exec('pod repo update', (err, stdout, stderr) => {
          if (err === undefined || err === null) {
            console.log('pod repo update successfull')

            exec('cd ./ios && pod install', (err, stdout, stderr) => {})

            return
          }

          console.log(stdout)
        })
      }
    } else {
      console.log('pod install sucessfull')
    }
  })
}

function installCocoaPods() {
  console.log('installing socoapods.')

  return new Promise((resolve, reject) => {
    run('sudo gem install cocoapods')
      .then(() => {
        console.log('sudo gem install cocoapods sucessfull')
        resolve()
      })
      .catch(e => {
        console.log(e)
      })
  })
}

// returns Promise which fulfills with true if command exists
function exists(cmd) {
  return run(`which ${cmd}`).then(stdout => {
    if (stdout.trim().length === 0) {
      // maybe an empty command was supplied?
      // are we running on Windows??
      return Promise.reject(new Error('No output'))
    }

    const rNotFound = /^[\w\-]+ not found/g

    if (rNotFound.test(cmd)) {
      return Promise.resolve(false)
    }

    return Promise.resolve(true)
  })
}

function run(command) {
  return new Promise((fulfill, reject) => {
    exec(command, (err, stdout, stderr) => {
      if (err) {
        reject(err)
        return
      }

      if (stderr) {
        reject(new Error(stderr))
        return
      }

      fulfill(stdout)
    })
  })
}

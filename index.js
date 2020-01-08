require("dotenv").config()
const shell = require("node-powershell")

let ps = new shell({
  verbose: true,
  executionPolicy: "Unrestricted",
  noProfile: true,
})

const dependencies = () => {
  ps.addCommand("./scripts/church-posh.dependencies.ps1").then(() => {
    ps.invoke()
      .then(output => {
        console.log(output)
      })
      .catch(err => {
        console.log(err)
        ps.dispose()
      })
      .finally(() => ps.dispose())
  })
}

const build = () => {
  ps.addCommand("./scripts/church-posh.build.ps1").then(() => {
    ps.invoke()
      .then(output => {
        console.log(output)
      })
      .catch(err => {
        console.log(err)
        ps.dispose()
      })
      .finally(() => ps.dispose())
  })
}

const publish = () => {
  ps.addCommand("./scripts/church-posh.publish.ps1")
    .then(() => {
      ps.addParameters([{ name: "apiKey", value: process.env.SNICOL_KEY }])
    })
    .then(() => {
      ps.invoke()
        .then(output => {
          console.log(output)
        })
        .catch(err => {
          console.log(err)
          ps.dispose()
        })
        .finally(() => ps.dispose())
    })
}

exports.dependencies = dependencies
exports.build = build
exports.publish = publish

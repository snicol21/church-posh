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

const publish = () => {
  ps.addCommand("./scripts/church-posh.publish.ps1")
    .then(() => {
      ps.addParameters([{ name: "apiKey", value: process.env.KEY }])
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
exports.publish = publish

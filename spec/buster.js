var config = module.exports;

config["My tests"] = {
  environment: "browser",
  extensions: [
    require("buster-coffee"),
    require("buster-sinon")
  ],
  rootPath: "../",
  libs: [
    "spec/lib/json2.js",
    "spec/lib/jquery-1.8.2.min.js",
    "spec/lib/underscore-1.4.0.js",
    "spec/lib/backbone-0.9.2.js",
    "spec/javascripts/spec_helper.coffee"
  ],
  sources: [
    "app/assets/javascripts/backbone/billing_walrus.js.coffee",
    "app/assets/javascripts/backbone/**/*.coffee"
  ],
  tests: [
    "spec/javascripts/**/*_spec.coffee"
  ]
}

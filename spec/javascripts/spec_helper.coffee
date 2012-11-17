# Stub out the JS Template global as we don't have the asset pipeline
window.JST = sinon.stub()
window.Handlebars = {}
window.Handlebars.registerHelper = sinon.stub()

# Make describe() available to the tests
buster.spec.expose()

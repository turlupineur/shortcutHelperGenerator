/*
 * generated by Xtext 2.15.0
 */
package shortcutHelper


/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
class ModelisationLanguageStandaloneSetup extends ModelisationLanguageStandaloneSetupGenerated {

	def static void doSetup() {
		new ModelisationLanguageStandaloneSetup().createInjectorAndDoEMFRegistration()
	}
}

/*
 * generated by Xtext 2.15.0
 */
package shortcutHelper.scoping

import com.google.inject.Inject
import java.util.ArrayList
import java.util.List
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IGlobalScopeProvider
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import shortcutHelper.modelisationLanguage.BackendParameterReference
import shortcutHelper.modelisationLanguage.CallComponentMethod
import shortcutHelper.modelisationLanguage.CallLogic
import shortcutHelper.modelisationLanguage.Command
import shortcutHelper.modelisationLanguage.CommandParameterReference
import shortcutHelper.modelisationLanguage.ComponentBackendParameterValueAttribut
import shortcutHelper.modelisationLanguage.Implementation
import shortcutHelper.modelisationLanguage.MethodArgumentValueAttribut
import shortcutHelper.modelisationLanguage.ModelisationLanguagePackage
import shortcutHelper.modelisationLanguage.Predicat
import shortcutHelper.modelisationLanguage.Service
import shortcutHelper.modelisationLanguage.UsingSystemKomponent
import shortcutHelper.modelisationLanguage.Variable
import shortcutHelper.modelisationLanguage.VariableValueAttribution
import shortcutHelper.util.ImplementationUtil
import shortcutHelper.modelisationLanguage.Shortcut

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class ModelisationLanguageScopeProvider extends AbstractModelisationLanguageScopeProvider {
	@Inject
	private IGlobalScopeProvider globalScopeProvider;
	
	override getScope(EObject context, EReference reference){
		if(context instanceof VariableValueAttribution){
			val VariableValueAttribution variableValueAttribution = context;
			if(reference == ModelisationLanguagePackage.Literals.VARIABLE_VALUE_ATTRIBUTION__VARIABLE){
				val EObject parent = variableValueAttribution.eContainer;
				if(parent instanceof Implementation){
					val Implementation implementation = parent;
					val List<Variable> allVariablesLocal = new ArrayList();
					for(implLine:implementation.implementationLines){
						if(implLine instanceof Variable){
							allVariablesLocal.add(implLine);
						}
					}
					val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
					return Scopes.scopeFor(allVariablesLocal,parentScope);
				}		
			}
		}
		
		// restrains to using components
		if(context instanceof CallComponentMethod){
			if(reference == ModelisationLanguagePackage.Literals.CALL_COMPONENT_METHOD__USABLE_SYSTEM_COMPONENT
			){				
				var EObject rootParent = ImplementationUtil.getRootParentImplementation(context);
				val CallComponentMethod callComponentMethod = context;
				
				var UsingSystemKomponent usingSystemKomponentObject = ImplementationUtil.getUsingSystemComponentFromObject(rootParent);
				
				if(usingSystemKomponentObject != null){
					val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
					
//					usingSystemKomponentObject = logic.usingSystemKomponent; 
					val IScope scope = super.getScope(context, reference);
					
//					usingSystemKomponentObject.components.removeIf( new Predicate<UsableSystemComponent>(){
//						override test(UsableSystemComponent t) {
//							return t instanceof Logic;
//						}
//					});
					
					val EList<EObject> elementsAvailable = ImplementationUtil.removeUndeclaredSystemComponents(scope.allElements,ImplementationUtil.getUsingSystemComponentComponentFromObject(callComponentMethod));
					
					return Scopes.scopeFor(elementsAvailable,parentScope);
				}
			}
		}
		// restraints to using Logic
		if(context instanceof CallLogic){
			if(reference == ModelisationLanguagePackage.Literals.CALL_LOGIC__LOGIC
			){				
				var EObject rootParent = ImplementationUtil.getRootParentImplementation(context);
				val CallLogic callLogic = context;
				
				var UsingSystemKomponent usingSystemKomponentObject = ImplementationUtil.getUsingSystemComponentFromObject(rootParent);
				
				if(usingSystemKomponentObject != null){
					val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
					
					val IScope scope = super.getScope(context, reference);
					
					val List<EObject> listLogicDeclared = ImplementationUtil.getUsingSystemComponentLogicFromObject(callLogic)
					
					val EList<EObject> elementsAvailable = ImplementationUtil.removeUndeclaredSystemComponents(scope.allElements,listLogicDeclared);
					
					return Scopes.scopeFor(elementsAvailable,parentScope);
				}
			}
		}
		if(context instanceof CallComponentMethod){
			if(reference == ModelisationLanguagePackage.Literals.CALL_COMPONENT_METHOD__METHOD){				
				val CallComponentMethod callComponentMethod = context;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				if(callComponentMethod.usableSystemComponent instanceof Service){
					val Service service = callComponentMethod.usableSystemComponent as Service;
					return Scopes.scopeFor(service.methods,parentScope);
				}
				return Scopes.scopeFor(new ArrayList<EObject>(),parentScope);
			}
				
		}
		if(context instanceof ComponentBackendParameterValueAttribut){
			if(reference == ModelisationLanguagePackage.Literals.COMPONENT_BACKEND_PARAMETER_VALUE_ATTRIBUT__PARAMETER){				
				val ComponentBackendParameterValueAttribut componentBackendParameterValueAttribut = context;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				val CallLogic callLogic = componentBackendParameterValueAttribut.eContainer as CallLogic;
				if(callLogic.logic.parameterDeclaration != null){
					return Scopes.scopeFor(callLogic.logic.parameterDeclaration.parameters,parentScope);
				}
			}else{
				val ComponentBackendParameterValueAttribut componentBackendParameterValueAttribut = context;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				val List<EObject> allAvailableVariablesAndParameters = ImplementationUtil.getAllAccessibleVariablesAndBackendParameter(componentBackendParameterValueAttribut);
				return Scopes.scopeFor(allAvailableVariablesAndParameters,parentScope);
			}
				
		}
		if(context instanceof MethodArgumentValueAttribut){
			if(reference == ModelisationLanguagePackage.Literals.METHOD_ARGUMENT_VALUE_ATTRIBUT__ARGUMENT){				
				val MethodArgumentValueAttribut methodArgumentValueAttribution = context;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				val List<EObject> argumentsToSet  = new ArrayList<EObject>(); 
					val CallComponentMethod callComponentMethod = methodArgumentValueAttribution.eContainer as CallComponentMethod
					argumentsToSet.addAll(callComponentMethod.method.arguments);
				return Scopes.scopeFor(argumentsToSet,parentScope);
			}else {
				val MethodArgumentValueAttribut methodArgumentValueAttribution = context;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				val List<EObject> allAvailableVariablesAndParameters = ImplementationUtil.getAllAccessibleVariablesAndBackendParameter(methodArgumentValueAttribution);
				return Scopes.scopeFor(allAvailableVariablesAndParameters,parentScope);
			}
		}
		if(context instanceof Predicat){
			if(reference == ModelisationLanguagePackage.Literals.PREDICAT_VALUE_EXPRESSION__VALUE){	
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				val List<EObject> allAvailableVariablesAndParameters = ImplementationUtil.getAllAccessibleVariablesAndBackendParameter(context);
				return Scopes.scopeFor(allAvailableVariablesAndParameters,parentScope);
			}
		}
		
		if(context instanceof BackendParameterReference){
			if(reference == ModelisationLanguagePackage.Literals.BACKEND_PARAMETER_REFERENCE__BACKEND_COMMAND_PARAMETER){
				val BackendParameterReference backendParameterReference = context;
				val Command command = backendParameterReference.eContainer.eContainer as Command;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				return Scopes.scopeFor(command.backendCommand.parameterDeclaration.parameters,parentScope);
			}
		}
		
		if(context instanceof CommandParameterReference){
			if(reference == ModelisationLanguagePackage.Literals.COMMAND_PARAMETER_REFERENCE__PARAM){
				val CommandParameterReference commandParameterReference = context;
				val Shortcut shortcut = commandParameterReference.eContainer as Shortcut
				val Command command = shortcut.command;
				val IScope parentScope = globalScopeProvider.getScope(context.eResource,reference,null);
				return Scopes.scopeFor(command.parameters,parentScope);				
			}
		}
		return super.getScope(context, reference);	
	}
}

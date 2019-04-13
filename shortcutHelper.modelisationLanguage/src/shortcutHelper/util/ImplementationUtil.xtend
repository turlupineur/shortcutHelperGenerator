package shortcutHelper.util

import java.util.ArrayList
import java.util.List
import org.eclipse.emf.common.util.BasicEList
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.resource.IEObjectDescription
import shortcutHelper.modelisationLanguage.Command
import shortcutHelper.modelisationLanguage.ConditionImplementation
import shortcutHelper.modelisationLanguage.Functionality
import shortcutHelper.modelisationLanguage.Helper
import shortcutHelper.modelisationLanguage.Implementation
import shortcutHelper.modelisationLanguage.ImplementationLine
import shortcutHelper.modelisationLanguage.Logic
import shortcutHelper.modelisationLanguage.Service
import shortcutHelper.modelisationLanguage.UsableSystemComponent
import shortcutHelper.modelisationLanguage.UsingSystemKomponent
import shortcutHelper.modelisationLanguage.Util
import shortcutHelper.modelisationLanguage.Variable
import shortcutHelper.modelisationLanguage.VariableContainer

class ImplementationUtil {
	/**
	 * Returs the root parent (Logic/Command...) of the object contained in the implementation.
	 */
	def static EObject getRootParentImplementation(EObject eobject){
		var EObject rootParent = eobject.eContainer;
		while(!(rootParent instanceof Logic || rootParent instanceof Functionality)){
			rootParent = rootParent.eContainer;
		}
		return rootParent;
	}
	
	def static UsingSystemKomponent getUsingSystemComponentFromObject(EObject object){
		var UsingSystemKomponent usingSystemKomponentObject = null;
		if(object instanceof Logic){
			usingSystemKomponentObject = object.usingSystemKomponent; 
		}
		if(object instanceof Functionality){					
			usingSystemKomponentObject = object.usingSystemKomponent; 
		}
		return usingSystemKomponentObject;
	}
	
	def static List<EObject> getUsingSystemComponentLogicFromObject(EObject object){
		val List<EObject> listUsedLogics = new ArrayList<EObject>();
		val EObject parentImplementation = getRootParentImplementation(object);
		val UsingSystemKomponent usingSystemComponent = getUsingSystemComponentFromObject(parentImplementation);
		val Iterable<UsableSystemComponent> iterable = usingSystemComponent.components.filter[it instanceof Logic];
		for (element : iterable) {
			listUsedLogics.add(element);
		}			
		return listUsedLogics;
	}
	def static List<EObject> getUsingSystemComponentComponentFromObject(EObject object){
		val List<EObject> listUsedComponents = new ArrayList<EObject>();
		val EObject parentImplementation = getRootParentImplementation(object);
		val UsingSystemKomponent usingSystemComponent = getUsingSystemComponentFromObject(parentImplementation);
		val Iterable<UsableSystemComponent> iterable = usingSystemComponent.components.filter[it instanceof Service || it instanceof Helper || it instanceof Util];
		for (element : iterable) {
			listUsedComponents.add(element);
		}
		return listUsedComponents;
	}
	
	def static Implementation getImplementationParent(EObject eobject){
		var EObject rootParent = eobject;
		while(!(rootParent instanceof Implementation || rootParent == null)){
			rootParent = rootParent.eContainer;
		}
		return rootParent as Implementation;
	}
	def static ImplementationLine getImplementationLineParent(EObject eobject){
		var EObject rootParent = eobject;
		while(!(rootParent instanceof ImplementationLine || rootParent == null)){
			rootParent = rootParent.eContainer;
		}
		return rootParent as ImplementationLine;
	}
	private def static List<VariableContainer> getAllVariableContainers(EObject eobject){
		var EObject parent = eobject;
		val List<VariableContainer> allVariableContainers = new ArrayList<VariableContainer>();
//		var VariableContainer lastVariableContainer = null;
//				lastVariableContainer = parent;
//				if(parent instanceof Condition && lastVariableContainer instanceof ElseCondition)
		while(!(parent == null)){
			if(parent instanceof VariableContainer){
				allVariableContainers.add(parent);
			}
			parent = parent.eContainer;
		}
		return allVariableContainers;
	}
	
	private def static List<Variable> extractAccessibleVariablesFromContainers(EObject eobject){
		val List<Variable> allAccessibleVariables = new ArrayList<Variable>();
		
		val List<VariableContainer> variableContainers = getAllVariableContainers(eobject);
		
		// We use a pointer to the last container in order to always only obtain variables declared before the last processed container
		// Otherwise, we would be getting the whole list, including variables that may have been declared after.
		var VariableContainer lastContainer = null;
		
		for(variableContainer: variableContainers){
			if(lastContainer != null){
				allAccessibleVariables.addAll(extractAccessibleVariablesFromCurrentContainer(variableContainer,lastContainer));
			}else{				
				allAccessibleVariables.addAll(extractAccessibleVariablesFromCurrentContainer(variableContainer,eobject));
			}
			
			lastContainer = variableContainer;
		}
		
		return allAccessibleVariables;
	}
	private def static List<Variable> extractAccessibleVariablesFromCurrentContainer(VariableContainer currentContainer,EObject eobject){
		return getLocalAccessibleVariablesDeclaredBeforeImplementationLine(currentContainer,eobject);
	}
	
	private def static List<Variable> getLocalAccessibleVariablesDeclaredBeforeImplementationLine(VariableContainer currentContainer, EObject eobject){
		val List<Variable> localVariablesDeclaredBeforeObject = new ArrayList<Variable>();
		val ImplementationLine implementationLineContainingEObject = getImplementationLineParent(eobject);
		val List<ImplementationLine> implementationLinesCurrentContainer = getImplementationLinesFromVariableContainer(currentContainer);
		var int cpt = 0;
		var boolean lineCurrentObjectReached = false;
		while(cpt<implementationLinesCurrentContainer.size && !lineCurrentObjectReached){
			val ImplementationLine containerImpLine = implementationLinesCurrentContainer.get(cpt);
			if(containerImpLine == implementationLineContainingEObject){
				lineCurrentObjectReached = true;
			}else{
				if(containerImpLine instanceof Variable){
					localVariablesDeclaredBeforeObject.add(containerImpLine);
				}
			}
			cpt++;
		}
		return localVariablesDeclaredBeforeObject;
	}
	
	def static List<ImplementationLine> getImplementationLinesFromVariableContainer(VariableContainer currentContainer){		
		if(currentContainer instanceof ConditionImplementation){
			val ConditionImplementation conditionImplementation = currentContainer
			return conditionImplementation.implementationLines
		}else if(currentContainer instanceof Implementation){
			val Implementation impl = currentContainer;
			return impl.implementationLines;
		}
		
		
		
		return new ArrayList<ImplementationLine>();
	}
	
	def static EList<EObject> removeUndeclaredSystemComponents(Iterable<IEObjectDescription> allElements, List<EObject> usableSystemComponents){ 
		val EList<EObject> elementsAvailable = new BasicEList<EObject>();
		for(element : allElements){
			val EObject eObject = element.EObjectOrProxy;
			if(eObject instanceof UsableSystemComponent){
				if(usableSystemComponents.contains(eObject)){
					elementsAvailable.add(eObject);
					elementsAvailable.add(eObject.eContainer);
				}
			}
		}
		return elementsAvailable;
	}
	
	def static List<Variable> getAllAccessibleVariables(EObject object){
		return extractAccessibleVariablesFromContainers(object);
	}
	
	def static List<EObject> getAllAccessibleVariablesAndBackendParameter(EObject object){
		val EObject parentImplementation = getRootParentImplementation(object);
		val List<EObject> accessibleObjects = new ArrayList<EObject>();
		accessibleObjects.addAll(getBackendParametersFromObject(parentImplementation));
		accessibleObjects.addAll(getAllAccessibleVariables(object));
		return accessibleObjects;
	}
	private def static List<EObject> getBackendParametersFromObject(EObject parentImplementation){
		val List<EObject> backendParameters = new ArrayList<EObject>();
		if(parentImplementation instanceof Logic){
			backendParameters.addAll(parentImplementation.parameterDeclaration.parameters);
		}
		if(parentImplementation instanceof Command){
			backendParameters.addAll(parentImplementation.parameters);			
		}
		return backendParameters;
	}
}
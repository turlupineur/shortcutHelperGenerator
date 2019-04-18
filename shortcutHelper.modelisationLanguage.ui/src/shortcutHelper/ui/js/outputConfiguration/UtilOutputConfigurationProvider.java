package shortcutHelper.ui.js.outputConfiguration;

import static com.google.common.collect.Sets.newHashSet;

import java.util.Set;

import org.eclipse.xtext.generator.IOutputConfigurationProvider;
import org.eclipse.xtext.generator.OutputConfiguration;

import shortcutHelper.generator.ModelisationLanguageGenerator;

public class UtilOutputConfigurationProvider implements IOutputConfigurationProvider {
	private static final String ROOT = "..";
	private static final String LOCAL_FOLDER_FOR_GENERATION = "/shortcutHelper/shortcutHelper";
	private static final String BACKEND = "/backend";
	private static final String LOCAL_FOLDER_FOR_BEANS = "/shortcutHelper/application_config";
	public static final String DEFAULT_OUTPUT_ONCE = "DEFAULT_OUTPUT_ONCE";

	public static final String SRC_GEN_JAVASCRIPT = "src-gen/main/java";
	public static final String SRC_GEN_ONCE_JAVASCRIPT = "src-gen-once/main/java";

	public static final String SRC_GEN_CONFIG = "/src-gen/main/resources";
	public static final String SRC_GEN_ONCE_CONFIG = "/src-gen-once/main/resources";

	@Override
	public Set<OutputConfiguration> getOutputConfigurations() {
		OutputConfiguration genUtil = new OutputConfiguration(ModelisationLanguageGenerator.UTIL_OUTPUT);
		genUtil.setDescription("Gen Folder");
		genUtil.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/util/" + SRC_GEN_JAVASCRIPT);
		genUtil.setOverrideExistingResources(true);
		genUtil.setCreateOutputDirectory(true);
		genUtil.setCleanUpDerivedResources(true);
		genUtil.setSetDerivedProperty(true);

		OutputConfiguration onceUtil = new OutputConfiguration(ModelisationLanguageGenerator.UTIL_OUTPUT_ONCE);
		onceUtil.setDescription("Output Folder (once)");
		onceUtil.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/util/" + SRC_GEN_ONCE_JAVASCRIPT);
		onceUtil.setOverrideExistingResources(false);
		onceUtil.setCreateOutputDirectory(true);
		onceUtil.setCleanUpDerivedResources(false);
		onceUtil.setSetDerivedProperty(true);

		OutputConfiguration genService = new OutputConfiguration(ModelisationLanguageGenerator.SERVICE_OUTPUT);
		genService.setDescription("Gen Folder");
		genService.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/service/" + SRC_GEN_JAVASCRIPT);
		genService.setOverrideExistingResources(true);
		genService.setCreateOutputDirectory(true);
		genService.setCleanUpDerivedResources(true);
		genService.setSetDerivedProperty(true);

		OutputConfiguration onceService = new OutputConfiguration(ModelisationLanguageGenerator.SERVICE_OUTPUT_ONCE);
		onceService.setDescription("Output Folder (once)");
		onceService.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/service/" + SRC_GEN_ONCE_JAVASCRIPT);
		onceService.setOverrideExistingResources(false);
		onceService.setCreateOutputDirectory(true);
		onceService.setCleanUpDerivedResources(false);
		onceService.setSetDerivedProperty(true);

		OutputConfiguration genHelper = new OutputConfiguration(ModelisationLanguageGenerator.HELPER_OUTPUT);
		genHelper.setDescription("Gen Folder");
		genHelper.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/helper/" + SRC_GEN_JAVASCRIPT);
		genHelper.setOverrideExistingResources(true);
		genHelper.setCreateOutputDirectory(true);
		genHelper.setCleanUpDerivedResources(true);
		genHelper.setSetDerivedProperty(true);

		OutputConfiguration onceHelper = new OutputConfiguration(ModelisationLanguageGenerator.HELPER_OUTPUT_ONCE);
		onceHelper.setDescription("Output Folder (once)");
		onceHelper.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + "/helper/" + SRC_GEN_ONCE_JAVASCRIPT);
		onceHelper.setOverrideExistingResources(false);
		onceHelper.setCreateOutputDirectory(true);
		onceHelper.setCleanUpDerivedResources(false);
		onceHelper.setSetDerivedProperty(true);

		OutputConfiguration onceLogic = new OutputConfiguration(ModelisationLanguageGenerator.LOGIC_OUTPUT);
		onceLogic.setDescription("Gen Folder");
		onceLogic.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/logic/" + SRC_GEN_JAVASCRIPT);
		onceLogic.setOverrideExistingResources(true);
		onceLogic.setCreateOutputDirectory(true);
		onceLogic.setCleanUpDerivedResources(true);
		onceLogic.setSetDerivedProperty(true);

		OutputConfiguration genLogic = new OutputConfiguration(ModelisationLanguageGenerator.LOGIC_OUTPUT_ONCE);
		genLogic.setDescription("Output Folder (once)");
		genLogic.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/logic/" + SRC_GEN_ONCE_JAVASCRIPT);
		genLogic.setOverrideExistingResources(false);
		genLogic.setCreateOutputDirectory(true);
		genLogic.setCleanUpDerivedResources(false);
		genLogic.setSetDerivedProperty(true);

		OutputConfiguration onceBackendCommand = new OutputConfiguration(
				ModelisationLanguageGenerator.FUNCTIONALITY_OUTPUT);
		onceBackendCommand.setDescription("Gen Folder");
		onceBackendCommand.setOutputDirectory(
				ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/functionality/" + SRC_GEN_JAVASCRIPT);
		onceBackendCommand.setOverrideExistingResources(true);
		onceBackendCommand.setCreateOutputDirectory(true);
		onceBackendCommand.setCleanUpDerivedResources(true);
		onceBackendCommand.setSetDerivedProperty(true);

		OutputConfiguration genBackendCommand = new OutputConfiguration(
				ModelisationLanguageGenerator.FUNCTIONALITY_OUTPUT_ONCE);
		genBackendCommand.setDescription("Output Folder (once)");
		genBackendCommand.setOutputDirectory(
				ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/functionality/" + SRC_GEN_ONCE_JAVASCRIPT);
		genBackendCommand.setOverrideExistingResources(false);
		genBackendCommand.setCreateOutputDirectory(true);
		genBackendCommand.setCleanUpDerivedResources(false);
		genBackendCommand.setSetDerivedProperty(true);

		OutputConfiguration onceBean = new OutputConfiguration(ModelisationLanguageGenerator.BEAN_OUTPUT);
		onceBean.setDescription("Gen Folder");
		onceBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_CONFIG);
		onceBean.setOverrideExistingResources(true);
		onceBean.setCreateOutputDirectory(true);
		onceBean.setCleanUpDerivedResources(true);
		onceBean.setSetDerivedProperty(true);

		OutputConfiguration genBean = new OutputConfiguration(ModelisationLanguageGenerator.BEAN_OUTPUT_ONCE);
		genBean.setDescription("Output Folder (once)");
		genBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_ONCE_CONFIG);
		genBean.setOverrideExistingResources(false);
		genBean.setCreateOutputDirectory(true);
		genBean.setCleanUpDerivedResources(false);
		genBean.setSetDerivedProperty(true);

		OutputConfiguration onceServiceBean = new OutputConfiguration(
				ModelisationLanguageGenerator.SERVICE_BEAN_OUTPUT);
		onceServiceBean.setDescription("Gen Folder");
		onceServiceBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_CONFIG);
		onceServiceBean.setOverrideExistingResources(true);
		onceServiceBean.setCreateOutputDirectory(true);
		onceServiceBean.setCleanUpDerivedResources(true);
		onceServiceBean.setSetDerivedProperty(true);

		OutputConfiguration genServiceBean = new OutputConfiguration(
				ModelisationLanguageGenerator.SERVICE_BEAN_OUTPUT_ONCE);
		genServiceBean.setDescription("Output Folder (once)");
		genServiceBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_ONCE_CONFIG);
		genServiceBean.setOverrideExistingResources(false);
		genServiceBean.setCreateOutputDirectory(true);
		genServiceBean.setCleanUpDerivedResources(false);
		genServiceBean.setSetDerivedProperty(true);

		OutputConfiguration onceUtilBean = new OutputConfiguration(ModelisationLanguageGenerator.UTIL_BEAN_OUTPUT);
		onceUtilBean.setDescription("Gen Folder");
		onceUtilBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_CONFIG);
		onceUtilBean.setOverrideExistingResources(true);
		onceUtilBean.setCreateOutputDirectory(true);
		onceUtilBean.setCleanUpDerivedResources(true);
		onceUtilBean.setSetDerivedProperty(true);

		OutputConfiguration genUtilBean = new OutputConfiguration(ModelisationLanguageGenerator.UTIL_BEAN_OUTPUT_ONCE);
		genUtilBean.setDescription("Output Folder (once)");
		genUtilBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_ONCE_CONFIG);
		genUtilBean.setOverrideExistingResources(false);
		genUtilBean.setCreateOutputDirectory(true);
		genUtilBean.setCleanUpDerivedResources(false);
		genUtilBean.setSetDerivedProperty(true);

		OutputConfiguration onceHelperBean = new OutputConfiguration(ModelisationLanguageGenerator.HELPER_BEAN_OUTPUT);
		onceHelperBean.setDescription("Gen Folder");
		onceHelperBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_CONFIG);
		onceHelperBean.setOverrideExistingResources(true);
		onceHelperBean.setCreateOutputDirectory(true);
		onceHelperBean.setCleanUpDerivedResources(true);
		onceHelperBean.setSetDerivedProperty(true);

		OutputConfiguration genHelperBean = new OutputConfiguration(
				ModelisationLanguageGenerator.HELPER_BEAN_OUTPUT_ONCE);
		genHelperBean.setDescription("Output Folder (once)");
		genHelperBean.setOutputDirectory(ROOT + LOCAL_FOLDER_FOR_BEANS + SRC_GEN_ONCE_CONFIG);
		genHelperBean.setOverrideExistingResources(false);
		genHelperBean.setCreateOutputDirectory(true);
		genHelperBean.setCleanUpDerivedResources(false);
		genHelperBean.setSetDerivedProperty(true);

		OutputConfiguration backendCommon = new OutputConfiguration(
				ModelisationLanguageGenerator.BACKEND_COMMON_OUTPUT);
		backendCommon.setDescription("Gen Folder");
		backendCommon.setOutputDirectory(
				ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/backendCommon/" + SRC_GEN_JAVASCRIPT);
		backendCommon.setOverrideExistingResources(true);
		backendCommon.setCreateOutputDirectory(true);
		backendCommon.setCleanUpDerivedResources(true);
		backendCommon.setSetDerivedProperty(true);

		OutputConfiguration backendCommonOnce = new OutputConfiguration(
				ModelisationLanguageGenerator.BACKEND_COMMON_OUTPUT_ONCE);
		backendCommonOnce.setDescription("Output Folder (once)");
		backendCommonOnce.setOutputDirectory(
				ROOT + LOCAL_FOLDER_FOR_GENERATION + BACKEND + "/backendCommon/" + SRC_GEN_ONCE_JAVASCRIPT);
		backendCommonOnce.setOverrideExistingResources(false);
		backendCommonOnce.setCreateOutputDirectory(true);
		backendCommonOnce.setCleanUpDerivedResources(false);
		backendCommonOnce.setSetDerivedProperty(true);

		return newHashSet(genUtil, onceUtil, genService, onceService, genHelper, onceHelper, onceLogic, genLogic,
				onceBackendCommand, genBackendCommand, onceBean, genBean, onceServiceBean, genServiceBean, onceUtilBean,
				genUtilBean, onceHelperBean, genHelperBean, backendCommon, backendCommonOnce);
	}

}

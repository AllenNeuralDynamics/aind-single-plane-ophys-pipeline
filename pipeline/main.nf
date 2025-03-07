#!/usr/bin/env nextflow
// hash:sha256:140e6b00a1f008aa1d76bccb89293a0d0ce86adb01c7376f4ddcce8e3fc956fa

nextflow.enable.dsl = 1

params.ophys_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_731012_2024-08-13_23-49-46'

ophys_to_aind_ophys_bergamo_stitcher_1 = channel.fromPath(params.ophys_url + "/", type: 'any')
ophys_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_3 = channel.create()
ophys_to_aind_ophys_extraction_suite2p_4 = channel.fromPath(params.ophys_url + "/data_description.json", type: 'any')
ophys_to_aind_ophys_extraction_suite2p_5 = channel.fromPath(params.ophys_url + "/session.json", type: 'any')
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_6 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_8 = channel.create()
capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_9 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12 = channel.create()
ophys_to_aind_pipeline_processing_metadata_aggregator_13 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')

// capsule - aind-ophys-bergamo-stitcher
process capsule_aind_ophys_bergamo_stitcher_1 {
	tag 'capsule-6802467'
	container "$REGISTRY_HOST/published/bdd26885-5b39-46e3-a1a5-3c00f9f96add:v2"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data' from ophys_to_aind_ophys_bergamo_stitcher_1.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bdd26885-5b39-46e3-a1a5-3c00f9f96add
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6802467.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_2 {
	tag 'capsule-7474660'
	container "$REGISTRY_HOST/published/91a8ed4d-3b9a-49c6-9283-3f16ea5482bf:v15"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_3.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_6
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=91a8ed4d-3b9a-49c6-9283-3f16ea5482bf
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v15.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_motion_correction_2_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-extraction-suite2p
process capsule_aind_ophys_extraction_suite_2_p_3 {
	tag 'capsule-9911715'
	container "$REGISTRY_HOST/published/5e1d659c-e149-4a57-be83-12f5a448a0c9:v9"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_extraction_suite2p_4.collect()
	path 'capsule/data/' from ophys_to_aind_ophys_extraction_suite2p_5.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_6

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7
	path 'capsule/results/*/*/*data_description.json' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=5e1d659c-e149-4a57-be83-12f5a448a0c9
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v9.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9911715.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_extraction_suite_2_p_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-dff
process capsule_aind_ophys_dff_4 {
	tag 'capsule-6574773'
	container "$REGISTRY_HOST/published/85987e27-601c-4863-811b-71e5b4bdea37:v4"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_8
	path 'capsule/results/*/*/*data_description.json' into capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=85987e27-601c-4863-811b-71e5b4bdea37
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-oasis-event-detection
process capsule_aind_ophys_oasis_event_detection_6 {
	tag 'capsule-8957649'
	container "$REGISTRY_HOST/published/c6394aab-0db7-47b2-90ba-864866d6755e:v6"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_8

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_description.json' into capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v6.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-pipeline-processing-metadata-aggregator
process capsule_aind_pipeline_processing_metadata_aggregator_7 {
	tag 'capsule-8250608'
	container "$REGISTRY_HOST/published/d51df783-d892-4304-a129-238a9baea72a:v4"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_9.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12.collect()
	path 'capsule/data/' from ophys_to_aind_pipeline_processing_metadata_aggregator_13.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d51df783-d892-4304-a129-238a9baea72a
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8250608.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_7_args}

	echo "[${task.tag}] completed!"
	"""
}

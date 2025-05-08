#!/usr/bin/env nextflow
// hash:sha256:a753b7378dfe163c24bf114274a316e65c32a6d74896954625d0b005d978d441

nextflow.enable.dsl = 1

params.ophys_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_772414_2025-01-31_13-09-59'

ophys_to_aind_pophys_converter_capsule_1 = channel.fromPath(params.ophys_url + "/", type: 'any')
ophys_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_5 = channel.create()
ophys_to_aind_ophys_extraction_6 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7 = channel.create()
ophys_to_aind_ophys_dff_8 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
ophys_to_aind_ophys_oasis_event_detection_9 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_10 = channel.create()
capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11 = channel.create()
capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_13 = channel.create()
ophys_to_aind_pipeline_processing_metadata_aggregator_14 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_16 = channel.create()
ophys_to_aind_ophys_classifier_17 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_18 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_23 = channel.create()
ophys_to_aind_ophys_nwb_24 = channel.fromPath(params.ophys_url + "/", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_25 = channel.create()
capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_26 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_27 = channel.create()
capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_28 = channel.create()
ophys_to_nwb_packaging_subject_29 = channel.fromPath(params.ophys_url + "/", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_30 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_35 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_36 = channel.create()
capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_37 = channel.create()
ophys_to_aind_bci_behavior_nwb_capsule_38 = channel.fromPath(params.ophys_url + "/", type: 'any')

// capsule - aind-pophys-converter-capsule
process capsule_aind_pophys_converter_capsule_1 {
	tag 'capsule-0547799'
	container "$REGISTRY_HOST/capsule/56956b65-72a4-4248-9718-468df22b23ff"

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data' from ophys_to_aind_pophys_converter_capsule_1.collect()

	output:
	path 'capsule/results/*' into capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=56956b65-72a4-4248-9718-468df22b23ff
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0547799.git" capsule-repo
	git -C capsule-repo checkout df1edf289e5e0a4d95dd3637cc0c6da6248127f9 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pophys_converter_capsule_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_2 {
	tag 'capsule-7474660'
	container "$REGISTRY_HOST/published/91a8ed4d-3b9a-49c6-9283-3f16ea5482bf:v18"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4
	path 'capsule/results/*/motion_correction/*.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_5
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_16
	path 'capsule/results/*/motion_correction/*.csv' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19
	path 'capsule/results/*/motion_correction/*.png' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20
	path 'capsule/results/*/motion_correction/*.webm' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22
	path 'capsule/results/*/motion_correction/*.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_23
	path 'capsule/results/*/motion_correction/*.csv' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31
	path 'capsule/results/*/motion_correction/*.png' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32
	path 'capsule/results/*/motion_correction/*.webm' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33
	path 'capsule/results/*/motion_correction/*.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_35

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
	git clone --branch v18.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_motion_correction_2_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-extraction
process capsule_aind_ophys_extraction_suite_2_p_3 {
	tag 'capsule-3592435'
	container "$REGISTRY_HOST/capsule/c9f136a2-67d7-4adf-b15a-e02af4237fa4"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_5.collect()
	path 'capsule/data/' from ophys_to_aind_ophys_extraction_6.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_18
	path 'capsule/results/*/extraction/*.h5' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_25
	path 'capsule/results/*/extraction/*.h5' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_30

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c9f136a2-67d7-4adf-b15a-e02af4237fa4
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3592435.git" capsule-repo
	git -C capsule-repo checkout 56f3af82a0be6a0a08f52aee0d9031b76996f66d --quiet
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
	path 'capsule/data/' from ophys_to_aind_ophys_dff_8.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_10
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_13
	path 'capsule/results/*/dff/*.h5' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_27
	path 'capsule/results/*/dff/*.h5' into capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_36

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
	container "$REGISTRY_HOST/published/c6394aab-0db7-47b2-90ba-864866d6755e:v7"

	cpus 4
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_oasis_event_detection_9.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_10

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=4
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
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
	path 'capsule/data/' from capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11.collect()
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_13.collect()
	path 'capsule/data/' from ophys_to_aind_pipeline_processing_metadata_aggregator_14.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_16.collect()

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

// capsule - aind-ophys-classifier
process capsule_aind_ophys_classifier_8 {
	tag 'capsule-0630574'
	container "$REGISTRY_HOST/published/3819d125-9f03-48f3-ba09-b44c84a7a2c7:v4"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_classifier_17.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_18

	output:
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11
	path 'capsule/results/*'
	path 'capsule/results/*/classification/*classification.h5' into capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_26

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3819d125-9f03-48f3-ba09-b44c84a7a2c7
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/2p_roi_classifier" "capsule/data/2p_roi_classifier" # id: 35d1284e-4dfa-4ac3-9ba8-5ea1ae2fdaeb

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-nwb
process capsule_aind_ophys_nwb_9 {
	tag 'capsule-9383700'
	container "$REGISTRY_HOST/published/8c436e95-8607-4752-8e9f-2b62024f9326:v13"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_23.collect()
	path 'capsule/data/raw' from ophys_to_aind_ophys_nwb_24.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_25.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_26.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_27.collect()
	path 'capsule/data/nwb/' from capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_28.collect()

	output:
	path 'capsule/results/*' into capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_37

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8c436e95-8607-4752-8e9f-2b62024f9326
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/schemas" "capsule/data/schemas" # id: fb4b5cef-4505-4145-b8bd-e41d6863d7a9

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v13.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9383700.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - NWB Packaging Subject
process capsule_nwb_packaging_subject_10 {
	tag 'capsule-8198603'
	container "$REGISTRY_HOST/published/bdc9f09f-0005-4d09-aaf9-7e82abd93f19:v3"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/ophys_session' from ophys_to_nwb_packaging_subject_29.collect()

	output:
	path 'capsule/results/*' into capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_28

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bdc9f09f-0005-4d09-aaf9-7e82abd93f19
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_nwb_packaging_subject_10_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-bci-behavior-nwb-capsule
process capsule_aind_bci_behavior_nwb_capsule_11 {
	tag 'capsule-9627003'
	container "$REGISTRY_HOST/capsule/8d045ee0-c23d-476f-a188-641161a9eb7e"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/processed/asset/extraction/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_30.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_35.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_36.collect()
	path 'capsule/data/nwb/' from capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_37.collect()
	path 'capsule/data/raw' from ophys_to_aind_bci_behavior_nwb_capsule_38.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8d045ee0-c23d-476f-a188-641161a9eb7e
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9627003.git" capsule-repo
	git -C capsule-repo checkout 0263aacd70508cdbb08c0d92cc3e337773e1047c --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

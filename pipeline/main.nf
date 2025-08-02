#!/usr/bin/env nextflow
// hash:sha256:baea711fad6a3992bbe8c87e7f6264bbe1be480bd111ec07edb133192497f593

nextflow.enable.dsl = 1

params.ophys_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_754303_2025-01-23_19-48-32'

ophys_to_aind_pophys_converter_capsule_1 = channel.fromPath(params.ophys_url + "/", type: 'any')
ophys_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4 = channel.create()
ophys_to_aind_ophys_extraction_5 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_6 = channel.create()
ophys_to_aind_ophys_dff_7 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
ophys_to_aind_ophys_oasis_event_detection_8 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_9 = channel.create()
capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10 = channel.create()
capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12 = channel.create()
ophys_to_aind_pipeline_processing_metadata_aggregator_13 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_14 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15 = channel.create()
ophys_to_aind_ophys_classifier_16 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_18 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22 = channel.create()
ophys_to_aind_ophys_nwb_23 = channel.fromPath(params.ophys_url + "/", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_24 = channel.create()
capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_25 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_26 = channel.create()
capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_27 = channel.create()
ophys_to_nwb_packaging_subject_28 = channel.fromPath(params.ophys_url + "/", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_29 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_30 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_35 = channel.create()
capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_36 = channel.create()
ophys_to_aind_bci_behavior_nwb_capsule_37 = channel.fromPath(params.ophys_url + "/", type: 'any')

// capsule - aind-pophys-converter-capsule
process capsule_aind_pophys_converter_capsule_1 {
	tag 'capsule-0547799'
	container "$REGISTRY_HOST/capsule/56956b65-72a4-4248-9718-468df22b23ff:b3faaa8ec4fc7f820d2e63229fa3ef7a"

	cpus 4
	memory '30 GB'

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
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0547799.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0547799.git" capsule-repo
	fi
	git -C capsule-repo checkout 983ca89031f5b5cc86f342a01b9d22d1a33cc66d --quiet
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
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15
	path 'capsule/results/*/motion_correction/*.csv' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_18
	path 'capsule/results/*/motion_correction/*.png' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19
	path 'capsule/results/*/motion_correction/*.webm' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21
	path 'capsule/results/*/motion_correction/*.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22
	path 'capsule/results/*/motion_correction/*.csv' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_30
	path 'capsule/results/*/motion_correction/*.png' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31
	path 'capsule/results/*/motion_correction/*.webm' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32
	path 'capsule/results/*/motion_correction/*.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=91a8ed4d-3b9a-49c6-9283-3f16ea5482bf
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v18.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	else
		git clone --branch v18.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	fi
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
	container "$REGISTRY_HOST/capsule/c9f136a2-67d7-4adf-b15a-e02af4237fa4:3d1825eb10b984d0abe5c9b8ebd0175f"

	cpus 8
	memory '60 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4.collect()
	path 'capsule/data/' from ophys_to_aind_ophys_extraction_5.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_6
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_14
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17
	path 'capsule/results/*/extraction/*.h5' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_24
	path 'capsule/results/*/extraction/*.h5' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c9f136a2-67d7-4adf-b15a-e02af4237fa4
	export CO_CPUS=8
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3592435.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3592435.git" capsule-repo
	fi
	git -C capsule-repo checkout 0ecc97a8e3cf4522dcb302d1902489156e2a80ee --quiet
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

	cpus 4
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_6
	path 'capsule/data/' from ophys_to_aind_ophys_dff_7.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_9
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12
	path 'capsule/results/*/dff/*.h5' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_26
	path 'capsule/results/*/dff/*.h5' into capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_35

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=85987e27-601c-4863-811b-71e5b4bdea37
	export CO_CPUS=4
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
	fi
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
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_oasis_event_detection_8.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_9

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=4
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
	else
		git clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
	fi
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
	tag 'capsule-0249670'
	container "$REGISTRY_HOST/capsule/2b968496-f5cd-47ce-b2ec-3c9d48c73a14:bd71a7af034314ca5a9719efd9c39421"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10.collect()
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12.collect()
	path 'capsule/data/' from ophys_to_aind_pipeline_processing_metadata_aggregator_13.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_14.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2b968496-f5cd-47ce-b2ec-3c9d48c73a14
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0249670.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0249670.git" capsule-repo
	fi
	git -C capsule-repo checkout 51fbabccca89050e39b674dd1270f00d4977d6bf --quiet
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
	path 'capsule/data/' from ophys_to_aind_ophys_classifier_16.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17

	output:
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_classifier_8_to_capsule_aind_pipeline_processing_metadata_aggregator_7_10
	path 'capsule/results/*'
	path 'capsule/results/*/classification/*classification.h5' into capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_25

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
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	fi
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
	tag 'capsule-2992649'
	container "$REGISTRY_HOST/capsule/4c09a8ff-66b1-4dbd-bf60-6fc4f3c5b96b:b45bdc4c8bbe3e921199f122fa7cabfa"

	cpus 2
	memory '30 GB'

	input:
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_18.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_19.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_20.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_21.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_nwb_9_22.collect()
	path 'capsule/data/raw' from ophys_to_aind_ophys_nwb_23.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_nwb_9_24.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_classifier_8_to_capsule_aind_ophys_nwb_9_25.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_nwb_9_26.collect()
	path 'capsule/data/nwb/' from capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_27.collect()

	output:
	path 'capsule/results/*' into capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_36

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4c09a8ff-66b1-4dbd-bf60-6fc4f3c5b96b
	export CO_CPUS=2
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/schemas" "capsule/data/schemas" # id: fb4b5cef-4505-4145-b8bd-e41d6863d7a9

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2992649.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2992649.git" capsule-repo
	fi
	git -C capsule-repo checkout fb930b836066f953a445c54008b3f11de536a112 --quiet
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

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/ophys_session' from ophys_to_nwb_packaging_subject_28.collect()

	output:
	path 'capsule/results/*' into capsule_nwb_packaging_subject_10_to_capsule_aind_ophys_nwb_9_27

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bdc9f09f-0005-4d09-aaf9-7e82abd93f19
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	fi
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
	tag 'capsule-0422462'
	container "$REGISTRY_HOST/capsule/d4dd20f2-48f6-4591-b2f2-4e046b6b0556:b2324f5b3e4ebc9b6557ce3fd513637e"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/processed/asset/extraction/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_bci_behavior_nwb_capsule_11_29.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_30.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_31.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_32.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_33.collect()
	path 'capsule/data/processed/asset/motion_correction/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_bci_behavior_nwb_capsule_11_34.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_dff_4_to_capsule_aind_bci_behavior_nwb_capsule_11_35.collect()
	path 'capsule/data/nwb/' from capsule_aind_ophys_nwb_9_to_capsule_aind_bci_behavior_nwb_capsule_11_36.collect()
	path 'capsule/data/raw' from ophys_to_aind_bci_behavior_nwb_capsule_37.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d4dd20f2-48f6-4591-b2f2-4e046b6b0556
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0422462.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0422462.git" capsule-repo
	fi
	git -C capsule-repo checkout 8c6e49ff531d74a74181306bf5a3085772343963 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

#!/usr/bin/env nextflow
// hash:sha256:dcd1450b286e973df86ba929133d8238e1b8869d5c581668ad2681ff79f781d2

nextflow.enable.dsl = 1

params.ophys_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_767715_2025-02-17_17-41-50'

ophys_to_aind_pophys_converter_capsule_1 = channel.fromPath(params.ophys_url + "/", type: 'any')
ophys_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_pophys_converter_capsule_1_to_capsule_aind_ophys_motion_correction_2_3 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_5 = channel.create()
ophys_to_aind_ophys_extraction_suite2p_6 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7 = channel.create()
ophys_to_aind_ophys_dff_8 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
ophys_to_aind_ophys_oasis_event_detection_9 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_10 = channel.create()
capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12 = channel.create()
ophys_to_aind_pipeline_processing_metadata_aggregator_13 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_14 = channel.create()
capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15 = channel.create()
ophys_to_aind_ophys_classifier_16 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17 = channel.create()

// capsule - aind-pophys-converter-capsule
process capsule_aind_pophys_converter_capsule_1 {
	tag 'capsule-0547799'
	container "$REGISTRY_HOST/capsule/56956b65-72a4-4248-9718-468df22b23ff:9c59c115ceb2eb78036bf6f73b8e3b61"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data' from ophys_to_aind_pophys_converter_capsule_1.collect()

	output:
	path 'capsule/results/*'
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
	git -C capsule-repo checkout 26c2b127281288fe5197185e663b91bef5011fba --quiet
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
	tag 'capsule-5379831'
	container "$REGISTRY_HOST/capsule/63a8ce2e-f232-4590-9098-36b820202911:0da186b632b36a65afc14b406afd4686"

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
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_pipeline_processing_metadata_aggregator_7_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=63a8ce2e-f232-4590-9098-36b820202911
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5379831.git" capsule-repo
	git -C capsule-repo checkout efd8fc219b7322ff4cbc765867ef70e4b6aa84bf --quiet
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
	tag 'capsule-3592435'
	container "$REGISTRY_HOST/capsule/c9f136a2-67d7-4adf-b15a-e02af4237fa4:5c573bd731b27103f675f902ccaf1198"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_4.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_5.collect()
	path 'capsule/data/' from ophys_to_aind_ophys_extraction_suite2p_6.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_7
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_pipeline_processing_metadata_aggregator_7_14
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17

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
	git -C capsule-repo checkout b1e169216f9774dbfcc96281e6053be97097df85 --quiet
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
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_dff_4_to_capsule_aind_pipeline_processing_metadata_aggregator_7_12

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
	tag 'capsule-0298748'
	container "$REGISTRY_HOST/capsule/382062c4-fd31-4812-806b-cc81bad29bf4:9087c2ff5cc907978b646b11a6cab48d"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_oasis_event_detection_9.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_10

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_oasis_event_detection_6_to_capsule_aind_pipeline_processing_metadata_aggregator_7_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=382062c4-fd31-4812-806b-cc81bad29bf4
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0298748.git" capsule-repo
	git -C capsule-repo checkout c62a395143428f5c6041e3bdfa25facf93add3c4 --quiet
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
	path 'capsule/data/' from ophys_to_aind_ophys_classifier_16.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_classifier_8_17

	output:
	path 'capsule/results/*'

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

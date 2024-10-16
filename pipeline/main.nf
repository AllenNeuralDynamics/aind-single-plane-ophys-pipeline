#!/usr/bin/env nextflow
// hash:sha256:c6ae29d00ef827c3a9fead7f68f2f1d31e981169f0fe0c2ce2c8b7530b77de2e

nextflow.enable.dsl = 1

params.ophys_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_731012_2024-08-13_23-49-46'

ophys_to_aind_ophys_bergamo_stitcher_1 = channel.fromPath(params.ophys_url + "/", type: 'any')
ophys_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_url + "/session.json", type: 'any')
ophys_to_aind_ophys_motion_correction_3 = channel.fromPath(params.ophys_url + "/data_description.json", type: 'any')
capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_4 = channel.create()
ophys_to_test_aind_ophys_extraction_suite2p_5 = channel.fromPath(params.ophys_url + "/data_description.json", type: 'any')
ophys_to_test_aind_ophys_extraction_suite2p_6 = channel.fromPath(params.ophys_url + "/session.json", type: 'any')
capsule_aind_ophys_motion_correction_2_to_capsule_test_aind_ophys_extraction_suite_2_p_3_7 = channel.create()
capsule_test_aind_ophys_extraction_suite_2_p_3_to_capsule_test_aind_ophys_dff_4_8 = channel.create()
capsule_test_aind_ophys_dff_4_to_capsule_test_aind_ophys_oasis_event_detection_6_9 = channel.create()
ophys_to_processing_json_aggregator_10 = channel.fromPath(params.ophys_url + "/*.json", type: 'any')
capsule_test_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_11 = channel.create()

// capsule - aind-ophys-bergamo-stitcher
process capsule_aind_ophys_bergamo_stitcher_1 {
	tag 'capsule-4194956'
	container "$REGISTRY_HOST/capsule/a8876b73-5b9f-40dd-90df-1af29add6807"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data' from ophys_to_aind_ophys_bergamo_stitcher_1.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a8876b73-5b9f-40dd-90df-1af29add6807
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4194956.git" capsule-repo
	git -C capsule-repo checkout 533a0bde3a50aab046f1c143081adad04409c8ca --quiet
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
	tag 'capsule-5379831'
	container "$REGISTRY_HOST/capsule/63a8ce2e-f232-4590-9098-36b820202911"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from ophys_to_aind_ophys_motion_correction_3.collect()
	path 'capsule/data/' from capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correction_2_4.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_2_to_capsule_test_aind_ophys_extraction_suite_2_p_3_7

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
	git -C capsule-repo checkout 680f04a2f4c97bbcd9740875e5b91edd4da52982 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - TEST aind-ophys-extraction-suite2p
process capsule_test_aind_ophys_extraction_suite_2_p_3 {
	tag 'capsule-0050492'
	container "$REGISTRY_HOST/capsule/43ebd21f-576b-491f-a9db-6aa66f02af9b"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_test_aind_ophys_extraction_suite2p_5.collect()
	path 'capsule/data/' from ophys_to_test_aind_ophys_extraction_suite2p_6.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_test_aind_ophys_extraction_suite_2_p_3_7

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_test_aind_ophys_extraction_suite_2_p_3_to_capsule_test_aind_ophys_dff_4_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=43ebd21f-576b-491f-a9db-6aa66f02af9b
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0050492.git" capsule-repo
	git -C capsule-repo checkout 28cebf69151913f44240494caf5d5c16ecbbbf94 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - TEST aind-ophys-dff
process capsule_test_aind_ophys_dff_4 {
	tag 'capsule-2484728'
	container "$REGISTRY_HOST/capsule/1867cc11-08d1-4b1a-b07c-aff3e944df18"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_test_aind_ophys_extraction_suite_2_p_3_to_capsule_test_aind_ophys_dff_4_8

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_test_aind_ophys_dff_4_to_capsule_test_aind_ophys_oasis_event_detection_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1867cc11-08d1-4b1a-b07c-aff3e944df18
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2484728.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - TEST aind-ophys-oasis-event-detection
process capsule_test_aind_ophys_oasis_event_detection_6 {
	tag 'capsule-0772112'
	container "$REGISTRY_HOST/capsule/8fcd1706-90cf-4804-8a39-3796d5af2285"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_test_aind_ophys_dff_4_to_capsule_test_aind_ophys_oasis_event_detection_6_9

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_test_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8fcd1706-90cf-4804-8a39-3796d5af2285
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0772112.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Processing json aggregator
process capsule_processingjsonaggregator_7 {
	tag 'capsule-1054292'
	container "$REGISTRY_HOST/published/2fafe85f-e0fa-41a7-b2a6-9ac24b88605d:v8"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_to_processing_json_aggregator_10.collect()
	path 'capsule/data/' from capsule_test_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_11

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2fafe85f-e0fa-41a7-b2a6-9ac24b88605d
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v8.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1054292.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

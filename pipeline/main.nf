#!/usr/bin/env nextflow
// hash:sha256:78db42ba6d9c05df73345b2fbf52703faa99c53bce371d8557b57b1de6885821

nextflow.enable.dsl = 1

capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_1 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_2 = channel.create()
capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_3 = channel.create()
capsule_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_4 = channel.create()

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_2 {
	tag 'capsule-5379831'
	container "$REGISTRY_HOST/capsule/63a8ce2e-f232-4590-9098-36b820202911:baabc08accddc0a0e01505e7dd64887a"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_1

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

	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/data_description.json" "capsule/data/data_description.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b
	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/session.json" "capsule/data/session.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b
	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00" "capsule/data/single-plane_harvard_2024-10-21_11-15-00" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5379831.git" capsule-repo
	git -C capsule-repo checkout d90aa8534a2b433a85692f36bb7ef57ce9e980dc --quiet
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
	container "$REGISTRY_HOST/published/5e1d659c-e149-4a57-be83-12f5a448a0c9:v6"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_2_to_capsule_aind_ophys_extraction_suite_2_p_3_1

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_2

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

	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/data_description.json" "capsule/data/data_description.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b
	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/session.json" "capsule/data/session.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v6.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9911715.git" capsule-repo
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
	container "$REGISTRY_HOST/published/85987e27-601c-4863-811b-71e5b4bdea37:v3"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_3_to_capsule_aind_ophys_dff_4_2

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_3

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
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
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
	container "$REGISTRY_HOST/published/c6394aab-0db7-47b2-90ba-864866d6755e:v4"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_dff_4_to_capsule_aind_ophys_oasis_event_detection_6_3

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
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
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_6_to_capsule_processingjsonaggregator_7_4

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

	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/data_description.json" "capsule/data/data_description.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b
	ln -s "/tmp/data/single-plane_harvard_2024-10-21_11-15-00/session.json" "capsule/data/session.json" # id: 165135d6-7730-4fd6-aba0-3539c270ae1b

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

#!/usr/bin/env nextflow
// hash:sha256:0229cb4ff6c416ef6d38fcc393bcb43271aa1f240df7c0d4fc269880ea4c18fa

nextflow.enable.dsl = 1

params.single_plane_ophys_731012_2024_08_13_23_49_46_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_731012_2024-08-13_23-49-46'

single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_bergamo_stitcher_1 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_2 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/session.json", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_3 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/data_description.json", type: 'any')
capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_4 = channel.create()
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_extraction_suite2p_al_test_5 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/data_description.json", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_extraction_suite2p_al_test_6 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/session.json", type: 'any')
capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_extraction_suite_2_paltest_3_7 = channel.create()

// capsule - aind-ophys-bergamo-stitcher
process capsule_aind_ophys_bergamo_stitcher_1 {
	tag 'capsule-4194956'
	container "$REGISTRY_HOST/capsule/a8876b73-5b9f-40dd-90df-1af29add6807:53d4e8c61b977fb18b2e478f537bdb11"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_bergamo_stitcher_1.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_4

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
	git -C capsule-repo checkout 79d53e46613254ed5fafdf16a694409996fceb37 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-motion-correction copy single plane test
process capsule_aind_ophys_motion_correctioncopysingleplanetest_2 {
	tag 'capsule-8090753'
	container "$REGISTRY_HOST/capsule/8a59647f-9d6b-40c1-979e-a0039f8e0071:43277c4dfb290c9cc8e8e8d70de07fa2"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_2.collect()
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_3.collect()
	path 'capsule/data/' from capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_4.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_extraction_suite_2_paltest_3_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8a59647f-9d6b-40c1-979e-a0039f8e0071
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8090753.git" capsule-repo
	git -C capsule-repo checkout 87c61944d15c20f0c1965617cdf27a000d7156fc --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-extraction-suite2p al test
process capsule_aind_ophys_extraction_suite_2_paltest_3 {
	tag 'capsule-4591920'
	container "$REGISTRY_HOST/capsule/9b5aca63-c509-4a2a-aeaf-92784bc2e842:71ddbdc0a5d49642b6eb084ed4eee185"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_extraction_suite2p_al_test_5.collect()
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_extraction_suite2p_al_test_6.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_extraction_suite_2_paltest_3_7

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9b5aca63-c509-4a2a-aeaf-92784bc2e842
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4591920.git" capsule-repo
	git -C capsule-repo checkout cd0ebf2e114e567edd64b06b476f6ada717a5bad --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

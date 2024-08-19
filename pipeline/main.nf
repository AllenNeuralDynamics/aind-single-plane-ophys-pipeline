#!/usr/bin/env nextflow
// hash:sha256:90d93a40d05bfd827e4c2b8655dd1ba6aa45a33cc7e040bbcef148dd789a5b2c

nextflow.enable.dsl = 1

params.single_plane_ophys_731012_2024_08_13_23_49_46_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_731012_2024-08-13_23-49-46'

single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_bergamo_stitcher_1 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_2 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/session.json", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_3 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/data_description.json", type: 'any')
capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_4 = channel.create()
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_segmentation_cellpose_bergamo_rr_5 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/data_description.json", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_segmentation_cellpose_bergamo_rr_6 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/session.json", type: 'any')
capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_segmentation_cellpose_bergamo_rr_3_7 = channel.create()

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
	path 'capsule/results/*' into capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_segmentation_cellpose_bergamo_rr_3_7

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

// capsule - aind-ophys-segmentation-cellpose-bergamo RR
process capsule_aind_ophys_segmentation_cellpose_bergamo_rr_3 {
	tag 'capsule-1527707'
	container "$REGISTRY_HOST/capsule/6fec0a64-6d57-491f-8819-039121bd2e2f:a1cc4d765c1e5a8c26395519488db6e9"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_segmentation_cellpose_bergamo_rr_5.collect()
	path 'capsule/data/' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_segmentation_cellpose_bergamo_rr_6.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correctioncopysingleplanetest_2_to_capsule_aind_ophys_segmentation_cellpose_bergamo_rr_3_7

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=6fec0a64-6d57-491f-8819-039121bd2e2f
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1527707.git" capsule-repo
	git -C capsule-repo checkout 2d8c607aa4f039d8a84c645d8259001bb78c86fb --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_segmentation_cellpose_bergamo_rr_3_args}

	echo "[${task.tag}] completed!"
	"""
}

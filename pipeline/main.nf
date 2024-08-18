#!/usr/bin/env nextflow
// hash:sha256:e5f8c42cd954aaf1c253c8358f6d4997337cc13d34b6629c6532cc5f4537cf4e

nextflow.enable.dsl = 1

params.single_plane_ophys_731012_2024_08_13_23_49_46_url = 's3://aind-private-data-prod-o5171v/single-plane-ophys_731012_2024-08-13_23-49-46'

single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_bergamo_stitcher_1 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/", type: 'any')
single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_motion_correction_copy_single_plane_test_2 = channel.fromPath(params.single_plane_ophys_731012_2024_08_13_23_49_46_url + "/session.json", type: 'any')
capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_3 = channel.create()

// capsule - aind-ophys-bergamo-stitcher
process capsule_aind_ophys_bergamo_stitcher_1 {
	tag 'capsule-4194956'
	container "$REGISTRY_HOST/capsule/a8876b73-5b9f-40dd-90df-1af29add6807:53d4e8c61b977fb18b2e478f537bdb11"

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data' from single_plane_ophys_731012_2024_08_13_23_49_46_to_aind_ophys_bergamo_stitcher_1.collect()

	output:
	path 'capsule/results/*' into capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_3

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
	git -C capsule-repo checkout 972c91efda0d746e194867eccbf9b48755ff7a72 --quiet
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
	path 'capsule/data/' from capsule_aind_ophys_bergamo_stitcher_1_to_capsule_aind_ophys_motion_correctioncopysingleplanetest_2_3.collect()

	output:
	path 'capsule/results/*'

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
	git -C capsule-repo checkout 72f91c8b22e4b6e776e592728f0fc31f646c3f7e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

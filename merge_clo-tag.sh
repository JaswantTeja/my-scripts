#!/usr/bin/env bash

gsa() {
	git remote add qcacld-3.0 https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0.git
	git fetch qcacld-3.0 $tag
	git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
	git read-tree --prefix=drivers/staging/qcacld-3.0 -u FETCH_HEAD
	git commit -s -m "Merge tag '${tag}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0"

	git remote add fw-api https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api.git
	git fetch fw-api $tag
	git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
	git read-tree --prefix=drivers/staging/fw-api -u FETCH_HEAD
	git commit -s -m "Merge tag '${tag}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api"

	git remote add qca-wifi-host-cmn https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn.git
	git fetch qca-wifi-host-cmn $tag
	git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
	git read-tree --prefix=drivers/staging/qca-wifi-host-cmn -u FETCH_HEAD
	git commit -s -m "Merge tag '${tag}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn"

	git remote add audio-kernel https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel.git
	git fetch audio-kernel $tag
	git merge -s ours --no-commit --allow-unrelated-histories FETCH_HEAD
	git read-tree --prefix=techpack/audio -u FETCH_HEAD
	git commit -s -m "Merge tag '${tag}' of https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel"

}
gsp() {
	git fetch qcacld-3.0 $1
	git merge -X subtree=drivers/staging/qcacld-3.0 --squash FETCH_HEAD
	git commit -S -s -m "Merge tag '${1}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qcacld-3.0"

	git fetch fw-api $1
	git merge -X subtree=drivers/staging/fw-api --squash FETCH_HEAD
	git commit -S -s -m "Merge tag '${1}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/fw-api"

	git fetch qca-wifi-host-cmn $1
	git merge -X subtree=drivers/staging/qca-wifi-host-cmn --squash FETCH_HEAD
	git commit -S -s -m "Merge tag '${1}' of https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn"

	git fetch audio-kernel $1
	git merge -X subtree=techpack/audio --squash FETCH_HEAD
	git commit -S -s -m "Merge tag '${1}' of https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel"

}
if [[ $1 != "" && $1 == "add" ]]; then
	gsa $2
else
	if [[ $1 != "" && $1 == "pull" ]]; then
		gsp $2
	fi
fi

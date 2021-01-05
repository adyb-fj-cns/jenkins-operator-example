up: install-operator install

down: uninstall uninstall-operator

install-operator:
	@kubectl apply -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/deploy/crds/jenkins_v1alpha2_jenkins_crd.yaml
	@kubectl apply -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/deploy/all-in-one-v1alpha2.yaml

install:
	@kubectl apply -f .

uninstall:
	-@kubectl delete -f .

uninstall-operator:
	-@kubectl delete -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/deploy/all-in-one-v1alpha2.yaml
	-@kubectl delete -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/deploy/crds/jenkins_v1alpha2_jenkins_crd.yaml

upgrade: install

get-credentials:
	@echo "Username: `kubectl get secret jenkins-operator-credentials-example -o jsonpath="{.data.user}" | base64 --decode`"
	@echo "Password: `kubectl get secret jenkins-operator-credentials-example -o jsonpath="{.data.password}" | base64 --decode`"

run-job:
	@curl -X POST \
		--user jenkins-operator:11903d5e2f4de5ce8800ef86bae78228b7 \
		http://localhost:30880/job/grafana-job/build
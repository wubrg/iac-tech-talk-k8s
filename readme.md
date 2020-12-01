# IAC Tech Talk K8s

## Deploying and Maintaining Code for Kubernetes

This repository is an example repo for common tooling to manage the source code for your Kubernetes clusters. In this repo you will find folders for helm, terraform, and kustomize. You will also see a docker folder that houses a nginx image used in all of the examples.

Each folder has the bare minimum of code to demonstrate what your actual source code would look like if you were to use the given tool to build and manage your services, etc on your k8s cluster.

This document will discuss the various strengths and weaknesses and some things to think about when using each tool to manage your k8s source code.

This document is meant to serve as a quick reference point for getting acquainted with a tool and understanding when and why you should use it.

## Tools
- [Kustomize](https://kustomize.io/)
- [Terraform K8s Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started)
- [Helm](https://helm.sh/docs/)
- [KotS](https://github.com/replicatedhq/kots) - TODO
- [K8sLens](https://k8slens.dev/) - TODO
- [Harness](https://harness.io/kubernetes/)  - TODO

### Kustomize

Kustomize is a tool that allows you to apply customizations to yaml files and output valid k8s yaml. It is a command line tool that is native to kubernetes.

#### Strengths

- Kustomize excels at providing powerful and simple layering of configuration to a set of base yaml configurations.

- It works with any yaml, not just k8s resources.

- Version control, everything in your `kustomization.yaml` file can be version controlled

- Its not helm.

#### Weaknesses

- Kustomize can take a while to get used to and can be especially hard to debug some error messages, #thanksYAML

- Requires a hand-rolled solution for state and secret management.

- At the end of the day you're combining yaml and sometimes you simply can't mash two things together without some really smart code, and kustomize is not that code.

#### Other Considerations

- Always reference tagged bases and overlays in your `kustomization.yaml`. This will avoid unexpected errors when making changes and promoting them to an environment.

- Treat the output of kustomize as a deployment artifact. Avoid using environment variables to provide information from the pipeline, instead the pipeline should build the dev artifact with dev values seeded from a dev patch.yaml that is version controlled. This will make pipelining much simpler.

- Kustomize is a fantastic tool to use when you are working with simple or complex k8s resources, as long as those do not require heavy conditional logic. It wants to be used is a highly modular fashion but you need to be careful. Avoid using highly variable overlays and bases. Instead prefer stochastic modules that are focused and narrow.

- Kustomize is not a tool to manage the actual state of your k8s infrastructure. It relies on kubectl or manual intervention to remove resources from the cluster that are no longer required.

- Version your kustomize cli tool to avoid weirdness when collaborating with others.

### Terraform Kubernetes Provider

HashiCorp has their own K8s provider that you can use to define your k8s infrastructure the same as you would any other infrastructure.

#### Strengths

- Integration with Terraform.

- The best state management out of the box.

- Write declarative K8s code with an actual language instead of a bunch of yaml.

- You can test that code!

- Excellent secret management integration.

#### Weaknesses

- That declarative language is HCL.

- Provider versions can lag behind official releases from K8s and you are reliant on HashiCorp to update.

#### Other Considerations

- TBD

### Helm Charts

Helm is a package manager for Kubernetes.

Helm installs charts (packages) into Kubernetes, creating a new release (version) for each installation. And to find new charts, you can search Helm chart repositories.

#### Strengths

- Community (OSS) packages for common software allows you to hit the ground running for standard solutions.

- Helm is a package manager and allows you to verify the integrity of your charts and allows you to sign them yourself.

- State management out of the box via helm cli tool.

- Supports conditional logic in charts via templating languange.

- Helm RBAC is equivalent to K8s RBAC.

#### Weaknesses

- Helm templates are cluttered and hard to parse, making contributing or writing your own charts cumbersome. And that's not even considering nested templates.

- Helm manages state but it is incomplete and often requires creative solutions to keep related dependencies updated when the underlying state files do not change themselves.

#### Other Considerations

- Community packages eventually will diverge from your use case and you'll be forced to fork or contribute back.

### KotS from Replicated

Kubernetes off the Shelf. Uses the kotsadmin cli to manage releases and deploy and monitor them. This sits on a level higher than Helm or Kustomize and focus more on the operations of your K8s infrastructure rather than your development.

#### Strengths

- GitOps integration baked in

- release and state management -> removes need to run kubectl apply locally, instead you get a nice ui thing to managed the already changed code on a branch / in master
- built in monitoring / logging support
- built on top of kustomize, same patterns for good kustomize code would apply to new releases for kots
- works with helm as well
- provides cluster pre-flight checks
- all open source

#### Weaknesses

- Must be KotS application compatible

- requires paid account with Replicated

- another abstraction layer to learn unique to itself

## K8sLens

K8sLens is an integrated K8s IDE. It hooks into your clusters and provides real-time visibility to monitoring and logs of your cluster resources. It provides shell hooks for pods and allows you to do real-time editing of resources.

It looks very promising as a development tool that warrants further testing.

#### Strengths

- very slick and integrated with k8s clusters you have access to

- makes the annoying work for debugging / verifying a deployed k8s manifest very simple

#### Weaknesses

- all changes are real-time to the configured cluster and thus are manually applied by the local workstation

- very new, most documentation is lacking

- not concerned with code management as much as high visibility and interoperability with existing configured clusters

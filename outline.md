# IAC Tech Talk

## Kubernetes Service Management

Demonstrate on local k8s cluster different methods of deploying and managing a service in k8s.

provide pros / cons to the _management_ of the service as it pertains to what the source code looks like and how that code can easily be maintained.

show community use - github stars/forks? -> can't get metrics for all of these.

discuss steps to use each piece?

discuss learning difficulty

Potential Tools
- (kustomize|https://kustomize.io/)
- (kots|https://github.com/replicatedhq/kots)
- (helm|https://helm.sh/)
- (terraform|https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/guides/getting-started)
- (harness?|https://harness.io/kubernetes/)
- (k8slens|https://k8slens.dev/)

### Kustomize - The bare bones approach

#### What is it?

Kustomize is a tool that allows you to apply customizations to yaml files and output valid yaml. It is a command line tool that is native to kubernetes.

#### How do I use it?

Kustomize is simply a tool to provide the yaml for your kubernetes code. It relies on kubectl to create the k8s infrastructure on a target cluster and relies on other software or tooling to manage that state. Kustomize can help apply _new_ changes to the target infrastructure, but only if those changes are additive. If you remove a resource from your source yaml and rebuild your kustomize yaml and reapply it you will have lingering k8s infrastructure to clean up.

Kustomize naturally fits into a module-centric approach to code. It works by specifying a set of base yaml files and a set of customized yaml files with patches to apply to the bases. You can create base modules for your common k8s objects and create overlay modules to apply overrides. You can reference git links for your bases and modules, which allows for proper versioning and promotion strategies to unfold. The end result of the kustomize cli is output to stdout. You can either compute this and execute with your pipeline or you can pipe it into a file and use as a deployment artifact in your pipelines.

## Considerations when using Kustomize to manage your service


#### Pros
- extremely flexible and easy to use
- allows the use of local or remote base/patch references
- native with k8s

#### Cons
- no state management, after applying a new rendered yaml any removed resources may still exist in k8s
- need to manually codify integration / deployment or find a third party to do so
- debugging error messages with bad yaml can be cryptic at times

### KotS

Managed by Replicated. Kubernetes off the Shelf. Takes care of all the 'dirty work' of deploying releases onto a given k8s cluster.

- https://kots.io/vendor/guides/cli-quickstart/
- https://kots.io/vendor/guides/ci-cd-integration/

#### What is it?

KotS is a managed kubernetes

#### How do I use it?

Requires:
- Replicated vendor account
- kots cli tools

#### Pros
- GitOps integration baked in
- release and state management -> removes need to run kubectl apply locally, instead you get a nice ui thing to managed the already changed code on a branch / in master
- built in monitoring / logging support
- built on top of kustomize, same patterns for good kustomize code would apply to new releases for kots
- works with helm as well
- provides cluster pre-flight checks
- all open source

#### Cons
- Must be KotS application compatible -> requires paid account with Replicated
- another abstraction layer to learn unique to itself

### K8s Lens

K8 IDE (not really a operations management tool)

#### Pros
- very slick and integrated with k8s clusters you have access to
- makes the annoying work for debugging / verifying a deployed k8s manifest very simple

#### Cons
- all changes are real-time to the configured cluster and thus are manually applied by the local workstation
- very new, most documentation is lacking
- not concerned with code management as much as high visibility and interoperability with existing configured clusters

### Terraform K8s Providers

#### Pros
- manage k8s state along with your TF code
-

#### Cons
- limited work on providers restricts ability to use all of what k8s can do
- another abstraction layer to the underlying k8s structures

### Helm

#### Pros

#### Cons

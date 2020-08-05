
# Introduction

> Using Kubebuilder v1? Check the [legacy documentation](https://book-v1.book.kubebuilder.io/)
>> https://book-v1.book.kubebuilder.io/

# 1. Tutorial: Building CronJob

## 1.2 Every journey needs a start, every program a main
> Every set of controllers needs a [Scheme](), which provides mappings between Kinds and their corresponding Go types. We’ll talk a bit more about Kinds when we write our API definition, so just keep this in mind for later.

> At this point, our main function is fairly simple:
  - > We set up some basic flags for metrics.
  - > We instantiate a [manager](), which keeps track of running all of our controllers, as well as setting up shared caches and clients to the API server (notice we tell the manager about our Scheme).
  - > We run our manager, which in turn runs all of our controllers and webhooks. The manager is set up to run until it receives a graceful shutdown signal. This way, when we’re running on Kubernetes, we behave nicely with graceful pod termination.

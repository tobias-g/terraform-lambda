# Terraform Lambda

I often need to setup Lambda functions deploying them as IaC in Terraform. This
repo contains the basic structure I lean towards when doing this.

There's more than one way to skin a cat and the same applies for how you deploy
Lambda functions as IaC. While this is one way to do that it may not be the best
depending on the exact scenario.

But it is the paradigm I use most often whenever I can due to its simplicity.

## No Prerequisite Build Steps

The core paradigm I follow is whenever I need to write a Lambda if I can I will
opt to not have prerequisite build steps.

So no TypeScript as that would need a build step to transpile into something the
AWS NodeJS runtime can understand.

And no node modules as that would need a `npm install` to be ran before
packaging up the Lambda code.

The reason for this is that I can drop into a repo; run `terraform apply` and
that's it! The same applies for the CICD pipelines. For me there's a certain
elegance to keeping things simple.

The counter argument is running `npm install` and maybe `npm run build` for
something like TypeScript to be transpiled isn't a huge deal. But for me if I
don't have to think about whether I remembered to run either of those, keep all
my dependencies up to date or have to wait a bit extra for CICD then all the
better.

## Dealing With No Node Modules

While initially not installing any other packages may sound daunting we have to
remember AWS Lambda functions come
[pre-packaged with the AWS SDK][lambda-dependencies] and many tasks can be done
with the NodeJS built in functions such as `fetch` from NodeJS v18.


[lambda-dependencies]: https://docs.aws.amazon.com/lambda/latest/dg/nodejs-package.html#nodejs-package-dependencies
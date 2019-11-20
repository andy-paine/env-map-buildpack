# env-map-buildpack

Allows for customised flattening of env vars in Cloud Foundry `VCAP_SERVICES` based on `jq` selectors. Requires a stack with `jq` already installed.

> NB: This is intended only for situations where high levels of customisation are needed e.g. 3rd party software. For most situations, the [pancake-buildpack](https://github.com/starkandwayne/pancake-buildpack) is likely a better option.

## Background

When using Cloud Foundry, services such as databases are provided by service bindings using the Open Service Broker API. The credentials, URLs etc. of these services are placed into a JSON formatted environment variable called `VCAP_SERVICES`. To consume these credentials applications typically either include code to parse the JSON or use custom entry scripts.

This buildpack utilizes the `profile.d` directory to supply a script that will export environment variables based on a selectors using the popular `jq` binary. Any scripts present in the `profile.d` directory will be `source`d when the application starts up.

## Usage

To use this buildpack, include (https://github.com/andy-paine/env-map-buildpack)[https://github.com/andy-paine/env-map-buildpack] anywhere but the last element in the `buildpacks` field in your Cloud Foundry manifest:
```yaml
buildpacks:
  - https://github.com/andy-paine/env-map-buildpack
  - python_buildpack
```
Include an `env-map.yml` file in the directory which you `cf push` - see [examples](examples/) directory for full details.

Any selector which works when performing `echo "$VCAP_SERVICES" | jq '<selector>'` will work with this buildpack.

This buildpack does not attempt to resolve situations such as multiple results returned by selector or invalid selectors.

> To use an alternative file name/location, set `ENV_MAP_BP_CONFIG` to the full path of your config file

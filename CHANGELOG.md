# Changelog

All notable changes to this project will be documented in this file.

## [2.1.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v2.0.0...v2.1.0) (2023-10-06)


### Features

* Add support for external integration with prometheus alertmanager for grafana ([#27](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/27)) ([a4bd8f4](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/a4bd8f4fa5bd3eef064c88c1ae0275663383a859))

## [2.0.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.10.0...v2.0.0) (2023-07-27)


### ⚠ BREAKING CHANGES

* Add support for `network_access_control`, updated minimum supported version of Terraform to `1.0` and AWS provider to `5.0` (#25)

### Features

* Add support for `network_access_control`, updated minimum supported version of Terraform to `1.0` and AWS provider to `5.0` ([#25](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/25)) ([9f025d9](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/9f025d98e691951b8e9db3992aa8293a1b49d3cf))

## [1.10.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.9.0...v1.10.0) (2023-05-09)


### Features

* Add support for Grafana version specification ([#21](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/21)) ([421b2b6](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/421b2b698a965ea4c983da7ccc8e716f76abb009))

## [1.9.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.8.0...v1.9.0) (2023-03-25)


### Features

* Control creation of SAML configuration via `create_saml_configuration` ([#20](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/20)) ([eb37802](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/eb3780220dc426166522197d7a35437ed4503990))

## [1.8.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.7.0...v1.8.0) (2023-02-02)


### Features

* Add workpace `configuration` argument ([#17](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/17)) ([85ada19](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/85ada198438acd218ee1e10850f2ff820de73be3))

## [1.7.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.6.0...v1.7.0) (2023-02-02)


### Features

* Add support for `vpc_configuration` along with creating an associated security group ([#15](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/15)) ([6d50e63](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/6d50e6336b44045ab63c6d1cac31514b61feee98))

## [1.6.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.5.1...v1.6.0) (2022-12-04)


### Features

* Add workspace ID as output attribute ([#11](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/11)) ([d2e19e9](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/d2e19e94eb72c6877372e75b1a8fd79fdc19a152))

### [1.5.1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.5.0...v1.5.1) (2022-11-07)


### Bug Fixes

* Update CI configuration files to use latest version ([#12](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/12)) ([8027f54](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/8027f549a69ac565bd13a0ed10e22844945eb68e))

## [1.5.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.4.0...v1.5.0) (2022-08-26)


### Features

* Add support for generating workspace API keys ([#9](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/9)) ([c45bf3b](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/c45bf3b9a3dcaf519f603292fd981c97f595e367))

## [1.4.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.3.1...v1.4.0) (2022-07-28)


### Features

* Add support for using an existing/external workspace ([#8](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/8)) ([eb31531](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/eb31531ab9af3393d601bdd6a7d243d8fa98b703))

### [1.3.1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.3.0...v1.3.1) (2022-06-27)


### Bug Fixes

* Correct policy ARN paths for Redshift and Athena to use service-role ([#6](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/6)) ([1cd2098](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/1cd2098bd93eea9f35b78b98f7dd51fe0791dd33))

## [1.3.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.2.0...v1.3.0) (2022-06-16)


### Features

* Add IAM permissions to support workspace role for `CURRENT_ACCOUNT` setting ([#3](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/3)) ([0cfb5e0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/0cfb5e07cd8f949075f5a0939f581b0fa6993672))

## [1.2.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/compare/v1.1.0...v1.2.0) (2022-06-07)


### Features

* Add support for Grafana workspace tags ([#2](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/issues/2)) ([35b32e9](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana/commit/35b32e9d4e3adb306f8b5e7315ee5c900fb88b4b))

## [1.1.0](https://github.com/clowdhaus/terraform-aws-managed-service-grafana/compare/v1.0.1...v1.1.0) (2022-04-20)


### Features

* Repo has moved to [`terraform-aws-modules`](https://github.com/terraform-aws-modules/terraform-aws-managed-service-grafana) organization ([3890f37](https://github.com/clowdhaus/terraform-aws-managed-service-grafana/commit/3890f3772e74becc18b3c506548d36d98bea9251))


### Bug Fixes

* Add path that will pick up change to initiate release for repo change ([0f01872](https://github.com/clowdhaus/terraform-aws-managed-service-grafana/commit/0f01872c8ea8bbe913323396f22deecd5f617d04))
